import requests

url = "http://localhost:8000"


def test_get_users():
    # Get all user
    payload = {}
    response = requests.get(url + "/users", json=payload)
    assert response.status_code == 200


def test_create_users():
    # Create user
    global payload
    payload = {
        "email": "testing@gmail.com",
        "password": "password",
    }

    response = requests.post(url + "/users", json=payload)
    global user_id
    user_id = response.json()["id"]
    # print(response.json())
    assert response.status_code == 201


def test_get_one_user():
    # Get one user
    get_one_user = requests.get(url + f"/users/{user_id}", json=payload)
    # print(get_one_user)
    # print(get_one_user.json())
    assert get_one_user.status_code == 200


def test_login():
    # Login
    login_payload = {
        "username": "testing@gmail.com",
        "password": "password",
    }

    global token

    global new_payload

    new_payload = {
        "email": "testing@gmail.com",
        "password": "password",
    }

    login = requests.post(url + "/login", data=login_payload)
    token = login.json()['access_token']

    assert login.status_code == 200


def test_update_user():
    headers = {"Content-Type": 'application/json', 'Authorization': 'Bearer {}'.format(token)}
    update_one_user = requests.put(url + f"/users/{user_id}", headers=headers, json=new_payload)
    # print(update_one_user)

    assert update_one_user.status_code == 200


def test_delete_user():
    headers = {"Content-Type": 'application/json', 'Authorization': 'Bearer {}'.format(token)}
    delete_one_user = requests.delete(url + f"/users/{user_id}", headers=headers, json=new_payload)
    # print(delete_one_user)
    assert delete_one_user.status_code == 204
