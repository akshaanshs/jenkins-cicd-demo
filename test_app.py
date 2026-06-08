import app

def test_add():
    assert app.add(2, 3) == 5

def test_subtract():
    assert app.subtract(10, 4) == 6

def test_multiply():
    assert app.multiply(3, 5) == 15