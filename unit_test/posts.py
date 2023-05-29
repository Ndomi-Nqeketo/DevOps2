import requests

url = "http://localhost:8000"


def test_get_posts():
    payload = {}
    response = requests.get(url + "/posts", json=payload)
    assert response.status_code == 200


def test_login():
    # Login
    login_payload = {
        "username": "test1@gmail.com",
        "password": "password",
    }

    global token

    global new_payload

    new_payload = {
        "email": "test1@gmail.com",
        "password": "password",
    }

    login = requests.post(url + "/login", data=login_payload)
    token = login.json()['access_token']

    assert login.status_code == 200


def test_create_post():
    global payload

    payload = {
        "title": "This is a post2",
        "content": "This is a post2",
    }

    headers = {"Content-Type": 'application/json', 'Authorization': 'Bearer {}'.format(token)}
    response = requests.post(url + "/posts", headers=headers, json=payload)

    global post_id
    post_id = response.json()["id"]
    assert response.status_code == 201


def test_get_one_post():
    get_one_post = requests.get(url + f"/posts/{post_id}", json=payload)
    assert get_one_post.status_code == 200


def test_update_user():
    new_payload = {
        "title": "Updated post",
        "content": "string",
        "published": True
    }
    headers = {"Content-Type": 'application/json', 'Authorization': 'Bearer {}'.format(token)}
    update_one_post = requests.put(url + f"/posts/{post_id}", headers=headers, json=new_payload)
    assert update_one_post.status_code == 200


def test_delete_post():
    headers = {"Content-Type": 'application/json', 'Authorization': 'Bearer {}'.format(token)}
    delete_one_post = requests.delete(url + f"/posts/{post_id}", headers=headers, json=new_payload)
    assert delete_one_post.status_code == 204
