import pandas as pd
import numpy as np
import os
import pickle
import gzip
from sklearn.ensemble import RandomForestClassifier

def read_intput_data():
    input_data = pd.read_csv("input.csv")
    input_features = input_data.columns
    return input_data[input_features]

def load_model():
    model_filename = "model.dat.gz"
    model = pickle.load(gzip.open(model_filename, "rb"))
    return model

def predict(model, data):
    y_pred_rf = model.predict(data)
    print("prediction : ", y_pred_rf)
    return y_pred_rf

model = load_model()
input_data = read_intput_data()
predict(model, input_data.values)
