#ifndef __AXI_BUS_DRIVER_H
#define __AXI_BUS_DRIVER_H

#include <stdio.h>
#include <stdbool.h>
#include "xil_types.h"
#include "xil_assert.h"
#include "xil_io.h"

typedef struct {
    volatile uint32_t *base_address;
    bool is_open;
} axi4_bus_device_t;

extern int32_t axi4_bus_open(axi4_bus_device_t *device, volatile uint32_t *base_addr);
extern int32_t axi4_bus_close(axi4_bus_device_t *device);
extern int32_t axi4_bus_read(axi4_bus_device_t *device, uint32_t offset, uint32_t *data);
extern int32_t axi4_bus_write(axi4_bus_device_t *device, uint32_t offset, uint32_t data);
extern int32_t axi4_bus_ioctl(axi4_bus_device_t *device, uint32_t command, uint32_t argument);

#endif
