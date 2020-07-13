import gc
import micropython
from machine import Timer

micropython.alloc_emergency_exception_buf(100)
gc.enable()
#gc.threshold(gc.mem_free() // 4 + gc.mem_alloc())
#gc.collect()

INFO_TIMER = 1
GC_TIMER = 2

def print_info():
    print("gc.mem_free() {} / gc.mem_alloc() {}".format(gc.mem_free(), gc.mem_alloc()))
    micropython.mem_info(1)

def gc_collect():
    print_info()
    print('collecting...')
    gc.collect()
    print_info()


timer = Timer(GC_TIMER)
timer.init(period=30000, mode=Timer.PERIODIC,
           callback=lambda t:gc_collect())


