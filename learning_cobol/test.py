import ctypes

test = ctypes.CDLL('./both.dylib')
test.cob_init()
test.hello_world()
test.sec()