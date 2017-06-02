import pandas as pd
import numpy as np
import os
import pickle
import gzip
from sklearn import model_selection
from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import LinearSVC
from sklearn.linear_model import SGDClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import accuracy_score

def save_model(model):
    model_filename = "model.dat.gz"
    pickle.dump(model, gzip.open(model_filename, "wb"))
    print("model saved")

def train_data():
    train = pd.read_csv("train.csv")
    features = train.columns[1:]
    X = train[features]
    y = train['label']
    return model_selection.train_test_split(X / 255., y, test_size=0.25, random_state=0)

def train_evaluate_model():
    X_train, X_test, y_train, y_test = train_data()
    model = RandomForestClassifier(n_estimators=50, n_jobs=-1)
    model.fit(X_train, y_train)

    y_pred_rf = model.predict(X_test)
    acc_rf = accuracy_score(y_test, y_pred_rf)
    print("accuracy : ", acc_rf)

def train_final_model():
    X_train, X_test, y_train, y_test = train_data()
    model = RandomForestClassifier(n_estimators=50, n_jobs=-1)
    model.fit(X_train, y_train)
    save_model(model)

train_evaluate_model()
train_final_model()
