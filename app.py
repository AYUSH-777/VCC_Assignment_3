from flask import Flask
import time
import threading
import os

app = Flask(__name__)

# Simulating 4 tasks
def task_1():
    while True:
        print("Task 1 Running - Low Resource")
        time.sleep(5)

def task_2():
    while True:
        print("Task 2 Running - High CPU")
        x = 0
        for i in range(10000000): x += i  # CPU-intensive task
        time.sleep(2)

def task_3():
    while True:
        print("Task 3 Running - Low Resource")
        time.sleep(5)

def task_4():
    while True:
        print("Task 4 Running - High CPU")
        x = 0
        for i in range(10000000): x += i  # CPU-intensive task
        time.sleep(2)

# Run tasks in background threads
for task in [task_1, task_2, task_3, task_4]:
    threading.Thread(target=task, daemon=True).start()

@app.route("/")
def home():
    return "Web Application Running!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
