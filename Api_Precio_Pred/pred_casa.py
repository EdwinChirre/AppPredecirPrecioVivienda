from fastapi import FastAPI
from pydantic import BaseModel
import pickle
import pandas as pd
import numpy as np
import uvicorn


app = FastAPI()

ml_model = pickle.load(open('rf_model.pkl','rb'))
imputer_model = pickle.load(open('imputer_model.pkl','rb'))
scaler_model = pickle.load(open('scaler_model.pkl','rb'))



class PrecioCasasPredIn(BaseModel):
    BsmtFinSF1: int
    GarageYrBlt: float
    p1stFlrSF: int
    GarageArea: int
    TotalBsmtSF: int
    YearBuilt: int
    GarageCars: int
    GrLivArea: int
    OverallQual: int

class PrecioCasasPredOut(BaseModel):
    precio_casa: float


@app.get('/')
def index():
    return{'mensaje': 'Estimacion precio de casa APP'}

@app.post('/preciocasa-predictions',response_model=PrecioCasasPredOut, status_code = 201)
def procesar_prediccion_diabetes(precios_pred_in: PrecioCasasPredIn):

    input_values = [precios_pred_in.BsmtFinSF1,
                    precios_pred_in.GarageYrBlt,
                    precios_pred_in.p1stFlrSF,
                    precios_pred_in.GarageArea,
                    precios_pred_in.TotalBsmtSF,
                    precios_pred_in.YearBuilt,
                    precios_pred_in.GarageCars,
                    precios_pred_in.GrLivArea,
                    precios_pred_in.OverallQual
                    ];

    features = [np.array(input_values)]
    features_df = pd.DataFrame(features)

    features_df.columns = ['BsmtFinSF1', 'GarageYrBlt', '1stFlrSF', 'GarageArea',
                            'TotalBsmtSF','YearBuilt','GarageCars','GrLivArea','OverallQual']

    names_colums = ['BsmtFinSF1', 'GarageYrBlt', '1stFlrSF', 'GarageArea',
                            'TotalBsmtSF','YearBuilt','GarageCars','GrLivArea','OverallQual']
                            
    features_df[names_colums] = imputer_model.transform(features_df[names_colums])
    features_df[names_colums] = scaler_model.transform(features_df[names_colums])


    #Generamos las predicciones
    prediction_values = round(ml_model.predict(features_df[names_colums])[0],2)  

    #Determinar la prediccion final
    #final_prediction = np.argmax(prediction_values)

    return PrecioCasasPredOut(precio_casa = prediction_values)




if __name__ == '__main__':
    uvicorn.run(app,host="0.0.0.0", port = 8000,debug =True)