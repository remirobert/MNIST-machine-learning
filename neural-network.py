import pandas as pd
import numpy as np
from nolearn.dbn import DBN
import timeit

def train_data():
    train = pd.read_csv("train.csv")
    features = train.columns[1:]
    X = train[features]
    y = train['label']
    return model_selection.train_test_split(X / 255., y, test_size=0.25, random_state=0)

def train_evaluate_model():
    X_train, X_test, y_train, y_test = train_data()
    model = DBN([X_train.shape[1], 300, 10],learn_rates=0.3,learn_rate_decays=0.9,epochs=15)
    model.fit(X_train, y_train)
    acc_nn = model.score(X_test,y_test)
    print(acc_nn)

train_evaluate_model()