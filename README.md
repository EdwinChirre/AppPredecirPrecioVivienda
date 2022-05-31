# Crear un app móvil para implementar un modelo ML

Se va a crear un app para predecir los precios de viviendas. 

Para ello, se seguirá el siguiente flujo de trabajo:

## 1. Entrenar un modelo para predecir los precios de la viviendas

- Se entrena el modelo con RandomForest y se originan los siguientes archivos en [Modelo](https://github.com/EdwinChirre/AppPredecirPrecioVivienda/tree/master/Modelo)

    a. [APPS_ML_PRED_CASA_EDWINCHIRRE.ipynb](https://github.com/EdwinChirre/AppPredecirPrecioVivienda/blob/master/Modelo/APPS_ML_PRED_CASA_EDWINCHIRRE.ipynb): Código de la construción del modelo
    
    b. rf_model.rar: Modelo entrenado (RandomForest)
    
    c. imputer_model.pkl: Para replicar la imputación con la que se entrenó
    
    d. scaler_model.pkl: Para replicar las escalas con las que se entrenó
    
## 2. Crear el API con FastAPI (back end)


- Se creará un api que pueda ser consumido por el modelo. Se encuentra en [Api_Precio_Pred](https://github.com/EdwinChirre/AppPredecirPrecioVivienda/tree/master/Api_Precio_Pred)

    a. [pred_casa.py](https://github.com/EdwinChirre/AppPredecirPrecioVivienda/blob/master/Api_Precio_Pred/pred_casa.py): Tiene la construcción del API
    
    b. Procfile
    
    c. requirements.txt
    
- Despliego el modelo en Heroku: [Api en heroku](https://api-pred-casa-edwchi.herokuapp.com/docs) https://api-pred-casa-edwchi.herokuapp.com/docs

## 3. Crear el App en flutter (front end)

- Se va a crear la estructura del app en flutter. Son todas las carpetas que se encuentran en el inicio (android, ios, lib, etc)

    a. El archivo [main](https://github.com/EdwinChirre/AppPredecirPrecioVivienda/blob/master/lib/main.dart)
    
    b. El archivo del formato del app es [pred_precio_form.dart](https://github.com/EdwinChirre/AppPredecirPrecioVivienda/tree/master/lib/screens)

## 4. Muestra del App

- El formulario del app se ve de la siguiente manera:

![Image text](https://github.com/EdwinChirre/AppPredecirPrecioVivienda/blob/master/FrontApp/Front_Formulario.jpg)

- Y front del valor predicho:
 
![Image text](https://github.com/EdwinChirre/AppPredecirPrecioVivienda/blob/master/FrontApp/Front_Predicho.JPG)

