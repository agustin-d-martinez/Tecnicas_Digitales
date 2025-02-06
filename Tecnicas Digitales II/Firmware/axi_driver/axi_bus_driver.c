#include "axi_bus_driver.h"

int32_t axi4_bus_open(axi4_bus_device_t *device, volatile uint32_t *base_addr)
{
    if (device == NULL)
		{
			return -1;
		}

    if (device->is_open)
    	{
            return -2;
        }

    device->base_address = base_addr;
    device->is_open = true;

    return 0;
}


int32_t axi4_bus_close(axi4_bus_device_t *device)
{
    if (device == NULL)
		{
			return -1;
		}

    if (device->is_open)
    	{
            return -2;
        }

    device->is_open = false;
    return 0;
}

int32_t axi4_bus_read(axi4_bus_device_t *device, uint32_t offset, uint32_t *data)
{
    if (device == NULL || !device->is_open || data == NULL)
		{
			return -1;
		}

    *data = device->base_address[offset];
    return 0;  // Éxito
}

int32_t axi4_bus_write(axi4_bus_device_t *device, uint32_t offset, uint32_t data)
{
    if (device == NULL || !device->is_open)
		{
			return -1;
		}

    device->base_address[offset] = data;
    return 0;  // Éxito
}

int32_t axi4_bus_ioctl(axi4_bus_device_t *device, uint32_t command, uint32_t argument)
{
    if (device == NULL || !device->is_open)
		{
			return -1;
		}

    switch (command)
		{
			case 0x01:
				break;
			case 0x02:
				break;
			default:
				return -1;
		}

    return 0;  // Éxito
}