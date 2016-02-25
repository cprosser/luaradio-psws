local ffi = require('ffi')

local radio = require('radio')
local jigs = require('tests.jigs')
local buffer = require('tests.buffer')

local SRC1_TEST_VECTOR = "\x35\xa2\x16\x3f\xfb\x9f\xcb\x3e\x4f\x88\x38\x3e\x2e\xa7\x01\x3f\xf0\x8a\x56\xbf\x49\xf9\xa4\x3e\xc8\x85\xa4\xbe\x93\x65\xf1\x3e\x3a\x25\x16\xbe\x1c\x7a\x0c\x3e\x40\x65\x45\xbf\x18\xe5\x63\xbf\x7b\xc5\x72\x3f\xf2\x53\xd2\x3e\xd5\xe8\x25\xbf\xec\x18\x73\x3f\x0a\x6a\xe4\xbe\x5e\x67\x95\xbe\x64\x65\x62\xbd\x0e\x4d\xb7\x3e\xf1\xe3\x19\x3e\x4a\x07\x18\x3f\x0e\xa9\xc5\xbd\x4c\xce\x22\xbf\x89\xd5\xa3\x3e\x48\xe1\x13\xbf\x02\x17\x46\x3e\xe9\x36\x36\xbf\x75\xea\x28\x3f\x48\x9c\x2a\x3e\x37\x4e\x73\xbf\x21\x3d\x2c\x3f\x97\x99\x66\xbf\x6c\xbe\x28\x3f\x64\x8b\x81\x3e\xce\x4b\x27\x3f\x6f\x74\x23\xbf\xba\x61\xfa\xbe\xa1\xa0\x57\x3f\x6d\x6d\xbb\xbe\x8b\xc7\x57\xbf\x5b\xa2\x94\xbe\x73\x8d\x57\x3f\x87\x2e\x73\xbf\xad\x2a\xb5\x3e\xdc\x62\xfa\x3e\x7e\x4d\xda\x3d\x58\xb2\x43\xbf\xac\x9b\x3b\xbf\x22\x05\x6f\xbf\x02\xb1\xb6\xba\x3a\xd2\xc1\x3e\xe3\x79\x56\x3c\x54\x0b\x36\x3f\x39\x8e\x38\xbf\xe7\xe8\xd3\xbe\x23\x4b\x41\x3f\xee\xee\x07\x3f\x60\x44\xc8\x3e\x4f\x8f\x98\x3e\x5a\x7e\x2d\x3f\x79\xa0\x7a\xbf\xf1\x61\x64\xbf\xaf\xc4\x09\x3f\xfb\x98\x42\xbe\x4b\x56\x6b\x3f\xed\x56\x79\x3f\x46\xb5\x6b\xbe\x84\x1c\xd2\xbe\xc2\x83\xe9\xbe\x98\x02\x45\x3f\xa1\x98\x69\x3f\x37\x84\x3f\x3e\x27\x3c\x04\x3f\x28\x48\x60\xbf\x57\x85\x8c\xbe\x06\x45\x90\x3e\x15\xe7\x64\x3f\xd4\xbb\xff\x3e\xf2\xea\x4b\xbf\x6e\xda\x25\xbf\x89\x7c\x65\xbf\x37\x0a\x0e\xbf\xd3\x6c\x34\xbf\x80\xa1\x11\xbe\xe7\x58\x52\x3e\xba\x36\xea\xbe\xd5\x6a\x26\x3f\x18\xe5\xdb\xbe\xeb\x97\x18\xbf\x63\x50\x33\xbf\xdc\x19\x09\x3f\xb3\x75\x65\xbf\x94\x38\x1b\x3f\x93\x97\xc1\x3e\xd1\xdb\x35\xbf\xb0\xa7\x5f\x3f\x16\xe0\x1d\x3f\x56\x5d\x68\xbe\xbb\xac\x17\x3f\xe9\x50\x5d\xbf\x19\xb1\xbb\x3e\x92\xee\x65\x3d\x7c\xfa\x18\x3f\xd5\xcc\x5a\xbf\x2a\x1c\xf6\x3c\x3c\xd2\xc9\x3e\x14\x26\xcc\x3d\x16\x2c\x4e\xbf\xc4\xe0\x9a\x3e\x99\x93\x5a\xbf\x62\xf8\x19\xbf\x6a\x7c\x1c\x3f\x36\x3c\xbc\x3e\x2a\x7a\x7c\x3f\x90\x62\xb0\x3e\x4c\x86\x26\x3f\xad\xd5\x75\x3f\x40\xa4\x88\xbe\x61\xbd\x8d\xbe\x20\xce\x62\x3f\x54\x07\x65\x3f\xc8\xfc\x22\x3f\xab\x55\x39\x3f\x0c\x4b\xb8\x3e\x1a\xd7\x9d\x3e\x91\x28\xb0\x3d\x78\x84\x45\x3f\x64\xd7\x3e\xbe\x46\xac\x64\xbf\xc8\x9e\x96\xbe\xc3\x5e\x77\xbf\x76\xe8\x4e\xbf\x7a\x9b\x0b\x3e\xe3\xdc\xa4\x3e\xad\xbc\x16\x3f\x2b\xe5\x70\x3f\x0a\x2c\xa5\xbe\x20\x38\x19\xbf\xa8\x76\xd3\xbe\x4d\x11\x5c\xbe\xcc\x4b\xfe\x3e\x88\x10\x00\x3e\x6c\x81\x27\x3f\x2a\x9a\x47\x3d\xeb\x5c\x73\xbf\x55\xa9\xca\xbe\x28\x71\xd1\xbe\x6e\xaf\x15\xbf\x49\x49\x5b\xbf\x6e\x29\x6a\x3f\xf9\x88\x20\x3f\x7d\xeb\x10\x3f\xbd\x49\x31\xbf\x03\x68\xe3\xbe\xe6\x8b\xe9\xbe\xbb\xed\xb0\xbd\xff\x4c\x15\x3f\xce\xad\x95\x3e\x11\x3e\xea\xbe\xc7\x04\x27\x3f\xb6\x31\x2e\x3f\xcc\x03\x7c\xbe\x5b\x25\x47\x3f\x7d\xd9\x12\x3f\x09\x5a\xf0\x3d\x0a\x7a\x15\x3f\x63\x80\x76\xbf\x79\x47\xe3\x3d\x30\x84\x41\x3f\x44\xb8\xcf\xbe\xbe\xe0\xfe\x3c\x51\x69\x57\x3e\x38\xaa\xaf\xbe\xd9\x65\x48\xbe\x3c\x73\x3f\x3f\x55\x2d\x47\x3f\xae\x6c\x7a\xbf\x0b\xeb\xfc\xbe\x7a\xa7\x63\xbf\x74\xe6\x46\xbe\xb9\xcd\x25\x3c\x6b\x79\x62\x3f\xe0\xf8\xa9\xbe\x95\xd6\x5d\x3f\x86\x99\x37\xbf\x36\xe0\xcf\x3d\x49\x82\x65\xbf\xc2\x24\xce\xbe\x60\x47\x95\x3e\x36\xf3\x22\x3f\x3d\x67\x51\x3f\x44\x58\x1a\x3e\x56\xc0\xdc\x3d\xd2\x50\x5f\x3f\x8f\x88\x7c\x3f\x22\x4e\x19\x3f\x9c\x7e\x09\xbf\x5f\xc4\xac\xbe\x1c\x2c\x5c\xbe\xc1\xcc\x96\xbe\x7f\x0f\xe1\xbe\xd6\x6b\x1b\xbf\x38\xc8\x12\xbf\x67\x25\x7d\x3f\x64\x9b\x73\xbf\x13\x31\x15\xbf\x24\x6b\x0e\xbd\x6b\x30\x61\xbf\xfd\x98\x06\x3c\xc4\xba\xed\xbd\x13\xda\x17\xbf\x87\x0b\xac\x3d\x87\x74\x73\xbf\xcc\xca\x55\x3f\x19\xd4\x79\xbf\x96\xba\xca\x3e\xaa\x0b\x3e\x3c\x7a\x0b\x5f\x3f\x4e\xb4\x1f\xbf\x16\xd5\x1f\x3f\x5d\x9f\x53\x3f\xde\xf8\x9c\x3e\x88\xa4\xbf\xbe\x01\x47\x48\xbf\xd0\x9a\x28\xbf\x37\xc8\x7b\xbf\x80\xc1\x32\x3f\x9b\x5f\x13\xbf\xd3\xbb\xe6\xbe\xbc\x2d\x6a\xbf\x5a\xeb\xe6\x3e\x8f\xae\x83\xbe\x2b\xcb\xa6\x3e\xf0\x93\x99\x3e\x87\x13\x31\xbe\xc9\xaf\xb1\x3e\xef\x0b\x10\x3e\x99\x3f\x6a\xbf\xcf\xa2\xb2\x3e\x27\xd3\x5b\xbf\x8b\x2a\xc4\x3e\x1a\xa6\x67\x3f\xd0\x14\x43\xbf\x7e\xbf\xfd\x3d\xbc\x21\x14\xbf\x74\xbf\x39\x3e\xab\xdb\x10\x3f\x19\xb5\xd7\xbe\x64\x15\x43\xbf\x39\x0b\xbb\xbe\x03\xaa\x9f\x3e\xbd\x04\xb3\x3e\xf2\x7d\x4e\xbf\x1d\x51\x32\xbd\xfe\xcc\xff\x3e\x4a\xd4\x4b\xbf\x8b\xd5\xe1\xbe\x7b\xbc\x67\xbd\x64\xe0\x7a\xbf\x02\x33\xce\xbe\xc1\xf0\x66\xbe\xe4\x0b\x0c\x3e\xe0\x3c\x4d\x3e\x42\xee\xd4\x3d\x96\x02\xb2\xbe\x7e\xce\x06\xbc\xf5\x2e\x25\xbe\x73\x7d\x0c\xbf\xd1\x27\xc0\xbd\x2b\xe3\x76\x3f\x51\x74\x5b\xbf\xdf\x3e\x3b\xbf\x0f\x70\xb6\x3e\x83\x17\x7b\x3e\xad\x35\x26\xbf\xa0\xba\x66\x3f\x5c\xb2\x68\x3f\xa4\x69\x56\xbf\x06\x91\xf6\xbd\xda\x3c\xa2\xbd\x48\x1a\x9b\xbe\x45\x65\xaa\x3e\xd4\xa2\x61\x3f\x8d\x00\x5e\xbf\xac\x45\x61\x3f\xbb\x1a\x19\x3e\x03\xb5\x3a\xbe\x9d\xe4\x21\xbf\x2f\x61\x54\xbd\xcf\x98\x20\x3f\x5f\xbf\xba\x3e\x99\x2e\x18\xbf\x73\x65\x07\xbe\x05\x70\x90\xbe\xe6\xf0\xa1\xbe\x1b\xa0\x1a\xbf\xc7\x63\x2c\xbf\x0a\x97\xa7\xbe\xf4\x51\x95\xbe\xb4\x31\x64\x3f\xad\x5c\x5b\xbe\xea\x89\xa8\xbd\xcb\xf7\x68\x3f\x2c\xc4\x40\x3f\xc4\xa4\xd2\x3e\x5a\x18\x26\xbf\x6a\xc7\x7f\x3f\xff\x4b\x70\x3d\x94\x20\xe0\x3e\x17\x91\xd6\xbe\xa6\x81\x2e\xbf\xc5\x7b\x71\x3f\xd1\x76\x21\x3f\x22\x89\x57\x3e\x32\x84\x01\x3f\xbf\x59\xf6\xbe\x2f\x97\x4c\xbf\xb5\xaa\xcc\xbe\xb5\x52\xca\x3e\x12\xf7\x5f\xbf\x68\x25\xd3\x3e\x71\xc9\x4c\x3f\xc6\x6b\xf9\x3b\x31\x16\x74\xbf\xc0\xe5\x3f\xbd\x79\x82\x2f\xbe\x4d\xd9\x40\xbf\x59\x35\xa6\x3e\x10\x80\x7c\x3f\xb1\x2e\x3c\x3f\x9a\xd8\x81\x3e\x29\xfe\x33\x3d\xe0\xb6\x07\x3e\x21\x3d\x09\x3f\xb6\x24\xbe\x3e\xec\x08\xe1\x3e\x79\x5a\x35\xbd\xd4\xaf\x39\xbf\xcc\x11\x08\xbe\x26\xe7\x0c\xbf\xb9\xae\x3d\x3f\x69\xf0\x31\x3f\x6d\xbb\xe3\xbd\x74\x53\x8d\x3e\xd4\x42\x29\x3f\xec\x8a\x19\xbf\x6f\x89\x0d\xbf\xe8\xf4\x23\x3f\x82\x1d\xce\xbe\x19\x8e\xa5\x3e\x23\xc6\x7c\x3f\x67\xaa\x2b\x3c\xf2\x5b\x79\x3f\x2a\x1e\xfa\x3e\xc7\x9f\xbb\xbe\x4c\x31\xd4\x3e\x60\x7d\x5c\x3f\xaa\xf1\xde\x3d\x4b\x40\xe6\x3e\xa0\x6a\x95\xbe\x3b\x5f\x01\x3f\xd8\xab\xe1\x3e\x7c\x94\x92\x3e\x08\xfe\x71\xbf\x98\x79\x3a\x3f\x52\x21\xfd\xbe\x16\x45\x57\x3f\x42\xd0\x39\x3f\x79\xe7\x16\x3e\xa5\x80\x56\x3f\x4d\x23\x56\x3d\x5c\xfb\x37\x3f\x65\xe6\x91\x3d\xde\xcf\x01\xbd\x37\x60\x5d\x3f\x04\x02\x0a\xbf\xa8\x35\x21\xbf\x1b\x32\x1c\x3f\xe7\xe6\x17\x3f\x0f\xce\xe9\x3e\xfc\x67\x38\xbf\xbd\x9f\x45\xbf\xec\xc4\xf5\xbd\x7a\xf3\x76\x3f\x49\x7a\x79\x3f\x39\xb1\xd8\x3d\x86\x6b\x50\x3f\x8b\xe2\xed\x3e\x51\xf5\xee\x3d\x8a\x43\x94\x3e\x30\x08\x64\x3f\x4f\x19\x20\xbe\x6c\xe0\xed\xbe\x17\x49\x7d\xbf\x1d\xf4\x5e\xbf\xed\x28\x37\xbf\xf1\x5b\x23\xbf\x18\xe7\xae\x3e\xf2\xab\x44\xbf\x98\xe7\x02\xbf\xff\xd0\x0f\x3f\xe2\x03\x25\x3c\xf6\x34\x51\x3f\xd9\xb8\xf4\xbe\x26\xec\x67\xbf\x0e\x2b\xf7\x3e\xd8\x0b\xaf\xbd\x9d\xe1\x4b\xbf\xdb\xdd\x16\x3f\xe4\x17\x3c\x3f\x26\x3b\x4d\x3f\xdd\xc4\xc0\x3e\xd8\x72\x20\x3f\xa6\x5f\x73\xbf\xe9\x2d\xcc\x3d\x49\xfa\x26\x3f\x7a\xe0\x08\x3f\xa0\x3e\x61\xbf\x51\x64\x31\x3f\x81\xb0\xb5\x3d\x58\x12\xac\xbe\x02\x52\xc5\xbe\xc7\x18\x6e\xbf\xc8\x87\xc8\x3e\xe8\x57\x1e\x3f\x80\xa0\xf6\xbd\x05\xbe\x46\x3f\x9a\x09\xe3\xbe\x18\x02\xd8\xbe\x27\xe6\x02\xbe\xda\xbb\xa2\xbc\x80\x16\x2c\xbf\xa2\x1d\x93\xbe\xd2\xf5\xef\x3e\x63\xf1\xea\xbd\x7c\x50\x0f\x3f\x0c\x30\x45\xbe\x3a\x57\xc5\xbe\x54\x9c\x6a\xbe\xdd\x86\x23\x3f\xee\x05\xa6\x3e\x4e\x72\x7b\x3f\xd7\x7e\x82\x3c\x95\xd1\x70\xbe\x71\xc8\xd5\xbe\xed\x18\x76\x3f\xb7\x16\x9e\xbe\xfa\x91\x43\xbe\x7b\xe6\x2c\xbe\xf3\x11\xe3\x3d\xb6\x9f\x28\x3e\xed\x42\x98\x3e\x4b\x8d\x9a\x3d\xf7\xf2\x47\xbf\x47\x3d\x45\x3f\x27\xc3\xf7\x3e\xb8\x79\x3e\x3f\xd0\xa2\xf2\x3e\x28\x66\xa4\x3d\x10\x76\x32\x3f\xc9\xea\x66\x3f\xb3\xc7\x36\xbf\x54\x67\x4f\xbf\x87\x5e\xb7\xbe\xf1\x2d\x92\xbe\xb7\x32\x5d\x3f\x45\xe2\x5e\x3f\x57\x94\x55\xbf\x1e\x8e\x32\xbf\xfe\xde\x27\xbe\x61\xb4\xe4\x3e\x74\x75\x8f\xbe\xdb\xda\x1e\x3f\xe5\x87\x80\xbe\x6b\x1b\x5a\x3f\x0e\xbd\xca\xbe\xc6\x1f\x72\x3e\x02\x6b\x3b\xbf\x32\x80\x7e\xbf\xf5\x83\x77\x3f\xe9\x75\xd9\x3d\xb4\x79\x51\xbf\xd8\x6d\x31\xbf\xcf\x11\xdf\x3e\x91\xf3\x53\x3d\x61\xe1\x2c\x3e\x98\x83\x1d\x3f\xc0\xba\xcc\xbe\x97\xdb\x1d\xbf\xfd\x31\x60\x3e\x7c\x94\xad\xbe\x30\xed\xd6\x3e\x06\x1a\x7f\xbe\x78\x5b\x17\x3e\xd4\x88\x3f\xbf\xd5\x5c\x99\xbe\xda\xae\x76\x3d\xde\x43\x2c\xbf\x90\x36\x86\x3e\x6a\x3f\x66\xbf\xbe\x4e\x6f\x3f\x2a\x9f\x97\x3d\x0c\x52\x24\xbd\x9d\x02\x36\x3f\x27\x87\xe6\xbe\x51\xe2\xed\x3e\xa7\x0e\x29\xbf\x48\xa5\x18\xbe\xce\x41\x29\xbf\xba\x6c\xc2\x3e\x08\x78\xd3\x3e\xc9\x97\x2d\xbf\x40\xc6\xd1\xbe\x7c\x4c\x03\x3f\xd3\x8c\x2d\x3f\xee\x52\x7d\xbf\x9c\x1b\x20\xbf\xe8\xc2\x67\x3e\x80\x95\x49\xbf\x7e\x09\x7d\xbd\x28\xf0\x0e\x3f\x40\x0f\xf6\x3d\x56\x8c\x6d\x3f\x49\x32\x8b\xbe\xad\x11\xa1\x3e\x42\xec\x1f\x3f\x89\xcd\xe6\x3e\xdb\x41\xdf\x3b\xcf\x9e\x55\xbe\x7b\x35\x21\x3f\x8e\x0a\x30\x3f\xc2\x5e\x40\x3f\x3e\x03\x4e\x3e\xf7\x68\x0b\xbf\x21\x2d\x7d\x3f\x1a\xf3\x24\x3f\xa9\x48\x47\xbf\x20\x78\x1b\x3f\xfe\x9b\x20\xbf\x15\x96\x8d\x3e\xf9\x97\x29\xbf\x9f\xf1\x9d\xbb\x56\xa1\x05\x3f\x60\xdf\xe3\x3e\xa6\x44\xfe\x3e\x8c\xb9\x63\x3f\xbd\x18\x20\xbf\x36\x47\xd2\x3e\x01\x53\x77\xbf\xbf\x83\xf2\xbe\x21\x1f\x2d\x3f\xfc\x0a\x1b\x3f\xa5\x6d\x15\x3f\x2c\x21\xee\xbe\xb1\x54\x77\xbf\x82\x15\xba\x3e\x51\x41\x3c\x3f\x48\xee\x47\x3f\x65\xef\x70\x3e\xc3\xb0\x06\x3e\x06\x07\xb2\x3e\xab\x47\xd7\xbe\x7d\x92\x3c\x3e\x3a\x8c\xf9\xbe\x71\x9e\x9a\xbc\x51\xa0\x13\x3f\x7d\xbd\x79\xbf\x8c\x66\xb9\xbe\xaf\x9e\xbd\x3d\x18\x38\x5b\x3f\xd3\xec\x57\x3e\x48\x4f\x45\xbe\xc5\x09\x8b\xbe\x4c\xa1\xd8\xbe\xa7\x9c\x4f\xbf\xca\xf4\xbd\xbe\x01\x37\xad\x3e\x3d\x99\x89\x3d\x7b\x9a\x0a\xbe\x10\x90\x20\xbf\xbc\x51\x79\x3f\x87\xc8\xab\xbe\x5e\xbc\x6c\xbe\xfe\x1a\x4c\x3f\x34\xdc\x1c\xbf\x3a\x9c\x7b\xbf\xa3\x3f\x21\xbf\xec\xa4\x4a\x3f\x6f\xba\x28\xbf\x26\x0a\x20\xbf\xaf\x71\xa3\x3e\xbc\x56\x3a\xbf\x05\x56\xbd\xbd\x2b\xf7\x44\x3d\xad\x8d\x59\xbe\xd9\x92\x4e\xbf\x1c\x2d\x0a\x3f\xfb\x3c\x72\x3f\x2d\x2c\x4a\xbf\x1e\xc4\x9e\x3e\xba\x8e\xf9\x3c\x77\x4f\xab\x3e\xde\x2c\x54\xbe\x0b\xbc\x4c\xbf\x46\x59\x8a\x3e\xb0\x06\x1f\x3f\x68\xe4\x05\xbf\x92\xe3\x3f\x3f\x64\x11\x0b\x3f\x0a\x92\x24\x3f\xed\x1a\x5f\xbf\x03\x38\x3d\xbf\x09\x6e\x05\x3f\x7c\xf9\x2d\xbf\x6e\xf0\xfb\xbe\x7d\xc7\x0b\x3f\x00\xf5\x50\x3f\xc6\xa7\x46\x3f\x59\x4f\x54\xbf\xd0\xe0\x27\x3f\xe3\x09\x49\x3f\xd9\xe3\x00\xbf\xcc\x52\x5c\xbf\xd4\x30\x36\x3f\x12\x9d\x18\x3f\x94\x80\x02\xbf\xdf\xd6\xaa\x3e\xbb\xab\xdd\x3e\x36\x6c\x30\xbf\x3a\x46\x0e\x3f\x68\x81\xdb\x3e\x04\x7b\x95\x3e\x37\x1d\x3e\xbf\x92\xf2\xf7\xbe\xbc\x09\x4c\xbe\x86\x07\x19\xbf\xbe\x29\xaa\xbe\x24\x10\x38\x3f\xdc\x49\x41\x3f\x4b\x2c\xbc\xbe\xf1\xeb\x6d\xbf\x36\xc2\x5f\x3f\x36\x0d\x38\xbf\x8f\x13\x82\x3c\x76\xdd\x12\x3f\x5b\x84\x96\xbe\x8e\x42\x74\xbe\xfd\x60\x43\xbf\x58\xe5\xc7\x3c\xcd\xed\xb6\xbd\x58\x6c\x3d\xbe\xec\x2b\x20\xbf\xd9\xc7\x50\xbf\xd2\xcf\x7a\x3f\xe9\xe2\x89\x3e\x23\xff\x16\x3f\x18\x0d\x1d\xbf\x8f\x4c\x39\x3f\x54\x96\x9c\xbd\x18\x26\x21\x3e\xcc\xd6\x2d\x3f\x64\x47\x6d\x3f\x1b\x38\x93\xbe\x72\xf3\x80\x3e\xd0\x11\x6e\x3f\x99\x8e\xf8\x3e\xbd\x14\x20\xbf\xc4\x16\x15\x3e\x5c\xac\xb4\x3a\xe6\x18\x83\x3e\xc5\x03\x62\xbf\xd3\x34\x27\xbf\xe7\x10\x4d\x3f\x36\x39\x2a\x3f\x04\x39\x62\xbe\xc3\x07\x5a\xbe\x3d\xe9\x92\xbe\xa9\x29\x18\xbf\x94\xfb\x15\xbc\xb7\x3a\xe8\xbc\xc9\xb7\x4b\x3f\x61\x19\x28\x3e\x52\xcc\x8e\xbe\xe8\x59\x6e\xbf\xa4\xe5\xd5\x3b\x15\x31\x6a\xbe\x73\x2e\x70\x3e\xaa\x8c\xba\x3e\x84\xe9\x5f\x3e\x11\xf6\x39\x3f\xd5\xa1\x2b\xbf\xc4\x43\x59\x3d\xb3\xec\x12\xbf\x65\x83\x6f\xbf\x9a\x29\x40\xbf\xfa\x56\xc3\x3e\x08\x75\x79\x3e\xaa\x17\x13\x3f\xf1\x40\x03\xbf\x96\x98\x57\xbe\x4c\x74\x3b\x3f\x42\x67\x28\xbf\xfd\xaf\x45\x3f\x78\xa9\x0d\xbe\x9b\xf1\x8c\x3e\x21\x5b\x71\xbf\xac\xb1\x45\x3f\x47\x33\x1e\x3e\xf0\xc7\xa9\x3e\x3f\x9e\x19\xbe\x23\x99\x3b\x3f\xf6\xd9\x51\xbf\x72\xa6\xb1\xbe\x3d\x5c\x61\xbf\x56\xb8\x44\x3f\xb6\x4d\x17\xbf\xa3\x28\xf4\x3e\x49\xc3\x2d\x3f\xc1\xc7\xea\xbe\xdb\x69\x52\xbf\x10\x6d\x15\x3f\x29\x2a\xc9\xbe\x4a\x62\xc6\xbe\x8d\x0d\x34\xbe\xbe\x77\x3e\x3f\x1b\x1c\x5e\x3f\x87\x5f\x87\x3e\xbf\xd1\x1f\x3f\xaa\xd3\x2a\xbf\x4d\x39\x58\x3e\x74\xcf\xd2\xbe\xff\xaf\x5a\xbf\x25\x95\x6d\x3d\x73\x6e\x44\x3f\x73\xb7\x6d\xbf\x64\xb6\xf2\x3e\x4d\x5a\x54\xbf\xca\x24\x18\x3f\x4b\x91\xfd\xbd\xe0\x47\x1c\x3f\x1c\x5e\x77\x3e\x0c\x5c\x73\xbe\xd9\xd8\x6f\x3f\xfb\x24\x3d\xbe\x47\x47\x85\xbe\xd2\x94\x1e\x3f\xda\x63\xf3\xbe\xd3\xb6\x58\x3c\x16\x32\x80\x3d\xe6\x7c\x35\xbf\x24\x04\x6c\x3f\x98\x6b\x6b\x3f\xbb\x2d\xa3\x3d\x6d\xc4\xe9\xbd\x0f\xac\x1e\xbe\x1e\x2c\x6c\xbf\xf6\x2b\x4d\xbf\x92\x1f\x5d\x3f\x28\x5b\x23\x3f\xd9\x80\x90\x3e\xb6\xf1\x02\x3c\x28\x2e\xe9\xbe\x67\x1e\x1b\xbf\xa5\x26\x6b\x3f\x33\x4d\x9a\xbe\x2f\xd4\x47\xbf\x5e\x50\xea\xbd\xae\xa8\x8b\xbc\x48\xda\x63\xbf\xfa\xcc\x1e\xbf\x54\x49\x16\xbf\x38\xae\x7e\xbf\x43\xcd\x73\x3f\xa8\x2b\xb3\xbe\xf4\xec\x01\xbf\x0b\x97\xf6\xbe\xa1\x6c\x78\xbf\x61\xd3\xe1\x3d\xb5\x49\x52\x3f\x3c\xd0\x62\x3f\x0b\x78\x83\xbe\xff\xf2\xf0\xbe\x92\x97\x57\x3f\x4b\xe2\x00\xbf\xf5\xca\x43\xbe\xbf\x89\xb9\xbe\xf7\xe2\x8b\x3e\xd6\x46\xc9\xbd\xaf\xb4\x08\xbf\xb8\xc7\x9b\xbe\x23\x79\x16\xbf\xbf\x6f\xaf\xbe\xbf\x63\x1d\xbf\xb0\xb7\x44\xbf\xee\xd2\x44\xbf\xc7\x84\x42\x3d\x6c\xb3\x10\xbf\x8a\x5e\xc4\xbe\x4b\x30\x20\x3e\xc4\x04\x0a\x3e\xc3\x33\x26\xbe\x22\x36\x6c\x3e\xc8\x7d\xc4\x3e\x90\x06\x89\xbd\xae\x7a\xe8\xbe\xd6\xc7\x38\xbe\xf9\x60\x74\x3e\xad\x5d\x0f\xbe\x48\x76\x79\x3e\x90\x41\x41\xbf\x7f\x7b\x32\xbe\x00\x9a\x66\xbf\x20\x24\x04\x3f\x9e\xf0\x6e\xbf\x04\x37\x38\xbf\x71\x4a\x4a\xbf\x23\x58\xe9\x3e\xba\x42\x87\x3e\x08\x3c\x6f\xbb\xd9\x44\xf4\x3e\x57\x81\xda\xbd\x34\x50\x10\x3f\x33\xf7\x94\xbd\x9d\xbb\x3e\xbd\xc0\xf8\x06\xbf\x71\x1f\x41\xbf\x0f\xbf\x78\xbf\x5c\x3c\x45\xbf\x13\x4c\x71\x3f\xcc\xbb\x4c\x3e\x3a\x81\x64\xbf\x3c\xcf\x23\xbe\x84\x46\x27\x3e\xb6\xa1\xb3\xbd\x53\xdb\x22\x3f\xda\x67\xd7\x3d\x96\x50\x7e\xbe\x40\xb2\x6f\xbf\xe4\x44\xbe\xbe\xb6\x4c\x68\x3f\x30\x24\x72\xbf\x96\x89\x4f\x3f\xb1\xb9\x88\x3e\xdf\x18\x01\xbf\x28\x26\x81\xbe\x52\x46\x7e\x3f\x06\x65\x46\xbb\xcf\xe6\x91\x3e\x56\xd1\x7a\x3e\x38\x2e\xfd\x3d\xf1\x2c\x8b\x3d\x83\xa3\x50\xbf\xb6\x4a\x26\xbf\x72\xfe\x18\xbf\xb4\x80\x79\x3f\x1c\x73\xce\xbd\x3d\x37\x0e\xbe\x60\xff\x42\xbf\x6e\x1b\xd3\xbe\xfd\xf2\x52\x3f\xfc\xee\xee\xbe\xf4\x9f\xcc\x3e\xee\x9d\x79\xbf\x31\x6e\xcf\xbe\x38\xeb\x15\x3e\x0f\xf7\x3e\x3e\x0a\xd1\x04\xbf\x4c\x46\x2f\x3f\xc5\x12\x7c\x3f\xcd\x86\x71\xbe\x10\xc1\x4b\x3f\xf0\x7b\xfa\xbe\xd8\x15\x3b\x3f\x59\x2a\xe2\x3e\x4a\xa4\x65\xbf\x32\xf5\x7b\xbf\x6f\xaf\xb4\x3d\xc3\x25\x37\xbe\xef\x1a\x74\xbf\xdb\x0c\x03\x3f\x23\x91\xd5\x3e\x2b\xb4\x19\xbf\x24\x2f\x30\x3f\xc6\x30\x06\xbf\xc5\x5f\x4e\xbf\xd6\xde\x66\xbf\xd9\x6d\x3a\x3f\x11\xaa\x79\xbf\xcf\x74\xe2\xbe\x19\x82\xff\xbe\xd6\xe4\x12\xbf\x65\xf2\xe3\xbe\xac\x0c\x7d\x3f\xd2\x6b\x5f\xbf\xd5\x13\x4f\xbf\x96\x9e\x6e\x3f\x03\x5e\x7f\xbf\xca\xe0\xc9\xbe\x10\x21\x61\x3f\x2e\xb7\x3a\x3f\xca\xf0\x6f\x3f\x82\xe8\x14\xbe\x26\xd6\x78\xbf\xe4\x91\x01\x3e\xd9\xea\xe3\x3e\x49\xac\xc1\xbe\x3e\xed\x85\x3e\x36\x3e\x3d\x3f\xba\x45\x0b\xbe\x99\x1b\x08\xbf\x56\x84\x1f\x3f\x8b\xb9\x78\x3f\x65\x1f\xc8\xbd\x06\xda\x9d\x3e\xd6\x28\x4d\x3f\x56\xf9\xb7\xbd\xae\xc6\x77\xbf\x22\x93\x5e\x3f\x5b\x6a\x7b\xbf\x44\x81\x8a\xbe\x9c\xc1\x63\xbf\x55\x85\x3d\xbf\x72\x91\xec\x3e\x36\xdd\xd0\x3e\x74\x53\x01\x3f\xb6\x08\x3c\xbf\x01\xba\x5e\x3f\x57\x2a\x18\xbf\xc9\x7b\xfa\xbe\x7d\xa2\xd1\x3e\xab\x77\xba\x3e\xd9\x9f\x16\x3f\x1a\x37\xdf\x3e\xb0\x0e\x5e\x3e\xf1\xd5\x72\xbf\x5c\xf7\x93\x3e\x90\x5b\x6c\xbf\x04\xaa\xbf\x3e\x37\x93\x20\xbe\x38\xcd\x38\xbe\x63\x69\x2e\xbf\xc4\xd5\xd1\xbe\x91\xe4\x46\xbe\x46\xa1\xe2\xbe\xbf\x4a\x05\x3e\x34\x4b\x7f\xbf\x41\x07\x97\xbe\x07\xb3\x4e\xbf\x11\x00\xce\xbe\x36\xf8\x93\x3e\xb5\x45\x1b\x3f\x44\xfd\x77\xbf\x87\xa5\x1f\xbf\xdc\x82\x28\x3f\x54\x1d\xc8\xbe\x04\x5f\xef\x3d\xdc\xbb\xef\xbe\x54\xb7\x69\x3d\x8b\xa5\x12\x3f\x2e\x1c\x27\x3d\xaf\x50\x44\xbf\x8b\x0d\x49\xbf\x85\x72\xb8\x3d\xd7\x7c\x5d\xbf\x2a\xfa\x5e\x3f\x3d\xb0\x11\xbe\x45\xdd\xc3\xbe\x86\x13\x29\xbe\x95\x48\xa4\xbe\x20\x21\x54\xbf\xca\xef\x08\x3f\x5b\x76\x0b\x3f\x4d\x19\x2d\xbf\xc2\x44\x4a\xbf\x26\xef\xbe\xbe\x9f\xba\x5a\x3f\xf8\x56\xe0\x3e\xf6\xc7\x09\xbf\xe2\x32\x6c\x3f\x0f\xf2\x74\xbf\x50\xd9\x47\x3f\x4f\x3c\x56\xbf\x01\x99\xd8\x3e\x17\x55\x1b\x3f\x70\x79\x8b\x3e\x50\x9b\xc8\xbe\x5f\xfc\x51\x3f\xe5\xc3\x4e\x3f\x3f\xb3\xde\x3d\xeb\xc5\x04\x3f\x06\xa3\x57\x3f\x61\x41\x50\x3e\x87\x01\x2d\x3f\x0e\xba\xcf\xbe\xba\x23\xdd\x3d\x17\xa0\x65\xbf\xa0\x98\x03\x3f\xe9\xf7\x99\xbe\x96\x72\x64\xbf\x57\x50\x56\xbf\xed\x4e\x34\x3f\xd9\xc9\x65\xbf\xe4\xfc\x30\x3f\x30\x9b\x28\xbf\x11\x06\xb3\x3e\xdb\x32\x42\xbf\x73\x12\x09\x3e\x3a\x48\x84\x3d\xf1\x0f\x7d\x3f\x21\xeb\x7a\xbf\x56\xcd\xd0\x3e\x27\xa4\x07\x3f\xf5\x89\x75\xbf\x7a\x9c\x37\xbf\xc8\x12\xf3\xbe\xec\x6a\x2d\xbd\x57\x16\xf3\x3e\xc4\x6e\xb9\xbe\x84\x1f\x90\x3e\x72\xe7\xec\x3d\x35\xad\xac\x3d\x4a\x60\xd7\x3e\x32\x8a\x06\xbf"
local SRC2_TEST_VECTOR = "\x9b\xe9\x05\xbf\xc7\x1f\x47\x3f\xfd\x20\xa9\x3e\xe5\x7f\x16\x3c\xcb\xde\x28\xbf\x20\xc6\x05\x3f\x4e\x3a\xaa\xbe\x28\x6a\x57\xbf\x9f\xee\x5d\xbf\x12\x4b\x93\xbe\xe7\x97\xaa\xbe\x58\x2b\x2b\xbf\xea\xa0\x98\xbe\xdf\x20\x0c\xbd\x24\xa3\x4a\x3f\x87\xa9\x5d\x3f\x0b\x61\x1f\xbf\x50\x81\xe0\xbe\x10\xc4\x3a\x3c\x17\x70\xe4\xbe\xbe\xaa\x57\xbf\x2f\x9e\x55\xbf\x51\x79\x58\xbf\x44\xc6\xf3\x3e\xf5\x7d\x7a\x3f\xa4\x8a\xad\xbe\xad\x2a\x21\xbf\x1e\x58\x5c\xbf\xa5\xb6\xdc\x3e\x90\x65\x6d\x3f\x3b\x10\x11\xbf\x81\xca\xf9\xbe\x35\xbc\x42\xbe\xf9\xdb\x7c\x3f\x72\x88\x3a\x3f\xce\x8a\x4e\x3f\x2a\x13\x87\xbd\x8e\x85\x66\x3f\x69\x78\xb0\x3d\xee\xdf\x49\x3f\xf4\x23\x07\xbf\xdf\xb6\x5c\x3f\x2f\x9f\x71\x3f\x54\x22\x2e\x3f\xa2\x47\x47\x3f\x53\xd5\x7b\xbf\x6d\xec\x42\x3f\xfe\xe1\x67\x3f\x24\x8d\xfc\x3e\xa8\xf9\x47\xbf\x7d\x03\xb8\xbd\xa8\x3f\x47\xbf\xba\xea\xbe\xbe\x67\xde\x7d\xbe\xb6\x78\x13\x3f\x01\xf2\x30\xbf\x3f\x2e\xed\xbd\xfe\x6e\xe7\x3e\xa0\x8d\x71\xbf\xbc\x2b\x0c\xbf\x23\x7a\x45\xbf\x4c\x63\x4d\x3f\xd1\x80\x51\x3f\x60\x4f\x91\x3e\x6c\x41\x48\x3f\xb0\xa2\x10\xbf\xaf\x29\x8f\xbe\xaf\xbd\x5f\x3f\x81\xa3\x10\x3f\x1b\xe9\x2c\x3e\xac\xce\x0d\x3f\xe5\x88\x21\x3f\xed\xbe\x26\x3e\xc7\xbd\xa4\x3e\x0e\x42\x75\x3f\x95\xc4\xca\x3e\x91\xab\x74\xbf\x96\x1e\xba\xbe\xc0\xc4\x76\x3e\xc7\x6e\xdf\xbd\x50\x9f\x5f\xbe\xef\xd9\xb9\x3d\xaf\x00\x23\xbf\x80\x83\x7f\xbe\xc4\xb0\x48\x3f\xe6\x11\x75\xbf\x93\x2f\xc4\x3d\xcc\x9a\xfd\xbe\x2d\x67\x71\x3f\x60\xec\x93\xbe\xa4\xf4\x7f\x3f\x02\xe1\x6d\x3f\xd9\x34\x5d\xbf\x4c\x89\xfb\xbe\x9e\x2e\x70\xbf\x71\x48\xa8\x3d\xee\x4c\xde\xbe\x05\x08\x73\x3e\x2d\x0c\x70\xbf\x0b\xde\x84\xbe\x86\x69\x7c\xbf\xc7\x16\xce\xbe\x20\x76\x23\xbf\x03\xd0\x6b\x3f\x7e\xa0\xa9\xbe\x62\x31\x1f\x3e\x5c\xeb\xb1\x3e\xa6\x85\x5c\xbf\xb9\x54\x49\xbf\xd7\xae\x1a\x3f\xe4\xc2\x75\x3f\xa1\xfc\x26\x3f\x20\x7b\xf2\xbe\xd3\x36\x39\xbf\x86\xe9\x27\x3f\x4e\xae\x18\xbf\xda\x7f\x7c\x3f\xec\x43\xd3\xbe\x7f\x42\x0e\x3f\x24\x09\xb9\x3e\x0b\x7d\x24\x3f\x2b\xd2\x3f\xbf\xbf\x9e\x6c\xbe\xe9\x58\xcd\xbe\x4a\x2c\x60\x3f\x15\x17\x41\xbf\xc8\xd3\x02\xbf\x7c\xda\xbb\x3e\x93\x6c\x4a\xbf\x4b\xec\x99\x3e\x3b\x43\x0f\xbf\x84\xe6\x77\x3f\x83\x3d\x6b\xbf\x1e\xc2\x56\x3f\x9e\xff\x63\xbf\xe0\x7c\xeb\xbe\x0e\xd9\x1b\x3e\x43\x6d\xf9\x3e\x79\xd5\xeb\xbe\x4a\x09\x5c\x3f\x83\x5b\xa3\x3e\x8e\x3d\x30\x3f\x0f\x75\x9b\x3e\xbe\x90\x48\x3f\x99\x06\x94\x3e\x56\x5a\xd9\x3e\xd8\x4d\x3c\x3f\x3b\x0b\x45\xbf\x2a\x31\x25\x3f\x83\xf3\xcf\x3e\x25\xed\x45\xbc\x9f\x64\x0d\xbf\x4e\x56\x77\x3c\xa1\x7a\x86\xbe\x1e\x3e\x2e\x3f\xbb\xc0\x2c\xbe\x59\x1d\x1f\xbf\xb8\x16\x39\xbf\x61\xd1\xc8\xbe\x4f\xb3\xe0\xbe\x42\xc5\x31\x3f\x4c\x61\x91\xbd\x2c\xfc\x7d\x3e\x3d\x67\x67\x3f\x83\x17\x7e\xbe\xc6\xdd\x03\x3f\x15\x9f\x48\xbf\x31\x1f\x45\x3f\xd7\xac\x27\x3f\x95\xeb\x5f\x3f\xc9\xc1\x18\xbf\xa8\x5a\x92\xbd\x0e\xee\x7c\xbf\x74\xef\xee\xbc\xdf\x0a\xaf\xbe\x17\x06\x4d\x3f\x1b\x48\x8f\xbe\x30\x94\x7f\x3f\x03\xde\x39\x3e\x7d\x26\x9e\x3e\xd6\x0c\xc5\xbd\xda\x72\x07\x3f\x8a\x5c\xcc\xbd\x81\x4d\x2b\xbf\x25\xd5\x26\x3f\x34\xfc\x35\xbf\x88\xfc\xe2\x3e\xbc\x6e\x27\x3f\x42\x30\x66\x3f\xf6\x7b\x10\x3f\x51\x11\x40\x3e\x7b\x31\xd5\xbe\xb5\x8f\xf7\x3d\xc4\xff\x58\x3f\xb9\x17\x4e\x3f\xf0\xad\xcc\x3e\x3a\x8b\x17\xbf\x33\x13\x69\x3f\xe9\xa2\xd7\xbe\xb8\xfe\x80\xbc\x77\xb5\x61\x3f\xd4\x76\x7e\xbf\x7b\xb2\x3e\x3f\x20\x98\x19\xbf\x3f\x89\x71\x3e\x83\xcc\x58\x3f\x3e\x2b\x0d\xbf\xad\x04\x2b\xbf\x5f\x7e\xb8\xbe\xa9\x08\xcc\x3e\xc0\xbc\xf6\x3e\xcd\xf0\x57\x3f\xda\x39\x06\x3e\x20\x5b\xad\xbe\x38\x7e\xdb\x3e\xa5\xe0\xb0\x3e\x6b\x25\xf2\x3e\x15\x41\xb8\x3d\x13\xee\xba\x3e\x60\x0e\xd7\xbe\xf0\x54\x07\xbe\x2c\x24\x24\x3d\x2e\x61\x59\xbf\x89\x3d\x54\xbf\xb9\x97\xc5\xbe\xb4\xc1\x83\xbe\x4f\x4a\xe3\xbe\xbe\xd9\xbd\xbe\xf7\x5b\x51\x3e\x1c\x99\x87\x3d\xdb\xf0\x01\xbf\xc3\xd5\x15\x3f\xa0\x23\xc2\x3e\x78\x39\x7d\x3e\x11\x9e\x1a\x3f\x24\x53\xce\xbe\xb7\x28\x47\x3f\x45\x14\xdc\x3e\xd4\x4b\x8b\x3e\x63\xa7\x79\xbf\x60\x33\xdb\xbe\x05\x86\x7a\x3f\xe6\x36\x45\xbc\x20\x00\x6b\xbf\x19\x26\x4d\x3e\x32\x7f\x49\x3f\x45\x6a\x16\x3e\x89\xb4\x12\x3f\xe7\xbf\x87\x3e\x59\x9a\x1f\xbf\xf4\x12\xa5\xbe\x1a\x26\x76\x3e\x1f\xe7\x4c\xbf\x1c\x3d\xf3\x3d\xa7\x69\x33\x3f\x64\x4c\x76\xbf\x0a\x9a\xed\xbd\xc4\x77\x0f\x3f\x74\x78\x6c\xbe\xf7\x8d\x91\x3e\xf3\x36\xcf\xbd\xba\xb3\x0d\xbf\x4f\x4f\x1c\xbe\x60\x72\xe7\xbe\x95\xfd\xed\x3e\x93\x87\x16\xbf\x38\x2a\xa4\x3e\xf4\x84\x1b\x3f\xf6\x03\x43\x3f\xfc\xed\xf0\x3c\x76\xc1\x7f\xbf\x51\x6b\xe9\xbe\x42\x19\x0e\x3f\x9a\x37\xf2\xbe\xd9\xf0\x51\x3f\x9b\xb2\x71\xbd\xdc\x3f\x2c\xbf\x31\x1b\xbc\xbe\xea\x71\x1f\x3f\x3c\xa4\x34\xbc\x6b\x3a\x7c\xbf\xc5\x48\x11\x3f\x16\x7f\x79\xbd\x5c\xdc\x14\xbf\x39\x83\x18\x3d\x48\x31\x6a\xbf\x22\x32\xaa\xbe\x03\xe8\xa8\x3d\x8e\x62\x2a\x3b\xac\x73\x08\x3e\xb8\x47\x4a\xbe\xb5\xf5\x70\xbf\xfa\x51\xc6\xbe\xfa\xc1\x07\x3f\x1c\x26\xf8\xbe\xa8\x9d\x5c\xbf\x23\x68\x4c\x3f\x4e\x1d\x1c\x3f\x86\xe1\xea\xbe\xc0\x13\x3a\xbf\x39\x0c\x56\xbf\x9c\x9a\x5f\xbe\x42\x33\x14\xbf\x73\x38\xcd\xbe\x66\xb0\x0e\xbf\x20\xc6\xf6\x3e\x9f\x37\x5f\x3e\xb9\xab\x68\xbf\x50\xfe\xdb\x3d\x6c\x75\x27\xbf\xcf\x0e\xcd\x3e\x5a\xaf\x26\xbf\xe8\x90\x80\xbe\x97\x33\x07\xbf\x2e\x65\x62\xbe\x64\x21\xb3\xbe\xda\x82\xd4\x3e\x9d\xef\x3b\x3f\xab\x1a\x29\x3f\x30\x82\x39\x3e\xbe\x19\x0f\xbf\xbf\x47\x4f\x3f\x7a\x17\x4d\xbf\x4b\xf7\x29\x3d\x90\x1e\x05\x3e\x2a\x03\xa0\x3d\x18\x82\x1e\x3f\x67\xdc\xfa\xbe\xbe\xfa\xee\xbe\x84\x38\x36\x3f\xf7\xb3\x92\x3e\xb1\x21\x64\x3f\x6d\x98\x5a\xbf\x9e\x82\x20\xbd\x04\x3c\x37\x3d\x5a\x54\x9c\x3d\x6a\x66\x77\x3f\x6f\xdc\x46\xbf\x6f\x76\x6a\xbf\x39\x32\xc4\x3d\x72\x81\x0c\xbf\x39\xab\xb9\xbd\x1a\x22\x29\xbf\x22\x71\x9e\x3e\x73\xc1\x45\x3e\x0a\x71\xad\xbe\x85\x94\x20\x3f\xae\x65\x31\xbf\xe3\xb4\x33\x3f\xd5\x37\x78\x3f\x4b\x1a\x52\x3f\xb9\xf8\xf1\x3d\x06\xec\x04\xbf\xbc\x32\xeb\xbe\x1a\x17\x1a\x3c\x53\x17\xaa\x3d\x44\x71\xd7\x3e\xcb\x9b\xf3\x3e\x7d\x85\x4f\xbf\xef\xc5\x40\x3f\x4d\x26\x9c\xbe\x4e\x7d\xeb\xbd\xb7\x22\x5a\xbf\xa9\xc8\x47\x3e\xeb\x83\x28\x3c\x8a\xd1\x3f\x3f\xb0\x0c\x46\x3f\x3e\x34\x2d\x3d\xfc\xdc\xed\x3e\xbc\xcd\x3e\xbf\x61\xf8\x12\xbf\xe6\xb3\xe5\xbc\xee\x42\xeb\xbe\x51\x1f\xfb\x3e\xe4\x7f\x3d\xbf\xdb\x76\x64\x3d\x68\xd7\x71\x3e\xef\x37\x7e\xbe\x9c\x36\x0e\x3e\x51\x8c\x9b\x3e\xfb\x79\x85\xbe\x48\x72\x48\xbf\x8a\xe4\x6e\x3d\x4f\x35\x5c\x3f\x4c\xc0\xaf\xbd\x72\x23\x3c\x3f\x36\x64\xd2\x3e\x00\xec\x42\x3f\x4c\xc8\x3d\x3f\xc4\xfc\xd0\xbe\x84\xf3\xde\xbd\xb5\x39\x88\xbd\xb6\x12\x11\xbf\x81\xf9\xd9\x3e\xe7\xf6\x79\xbf\x85\xaa\xfe\xbe\x33\x62\x2a\xbf\x58\x5a\x2c\xbf\x67\x3d\x60\xbf\x9b\x24\x91\xbc\xbf\x8d\x0f\x3f\x00\x56\x54\xbb\x0b\x4d\x0e\x3f\xd3\x05\x62\xbf\x9d\x9d\x00\x3f\x13\xc3\x31\xbf\x16\x0b\x36\x3f\xbc\x80\x3b\x3f\xa4\x80\x67\xbf\x1c\x86\xb6\xbd\x55\x1d\x77\x3e\x16\x20\x7d\x3f\x59\x38\x5e\xbe\x56\xbd\xcf\x3e\xd1\xb0\x66\xbf\x5a\x38\x01\xbf\x33\x55\x41\xbe\x46\x0b\x74\xbe\x6a\x92\xa2\x3e\xeb\xe8\x72\xbf\xba\xc4\xc6\x3e\x13\x26\x06\xbe\xa1\x20\x1a\x3f\x52\x03\x51\xbe\x41\x3a\x49\x3f\x3b\xe5\x77\x3f\x84\x8b\xb1\x3e\xe3\x65\xad\x3d\x8a\xc9\x1a\xbf\xe4\x32\x21\x3f\x95\x56\xb4\xbe\x0e\x4a\x27\x3f\x91\xdf\x20\x3e\xb9\x11\x4c\xbf\xe3\x3a\xb1\xbe\x5c\x9a\x5f\xbf\xe0\x91\xab\x3e\x6b\x4f\x4c\xbf\xfb\xbc\xb2\x3e\xcf\x4d\x91\x3e\x6d\x0e\x24\x3f\x0d\x94\x7e\x3f\x1e\x5a\x3a\x3f\xd6\xd6\x2f\x3f\xd9\x47\x45\xbf\x24\x81\x1e\xbf\xe3\x1a\xb9\x3e\xae\xa9\x23\xbf\x37\x71\x4b\xbf\x41\x92\xba\xbe\x66\xb9\x84\x3e\x14\xf6\x1a\xbf\x83\xd5\xa9\xbe\x44\xf0\xef\xbe\x8b\x0c\xa9\xbe\xb5\xe6\x20\x3f\x62\xa2\x73\x3e\x9a\xac\x50\xbf\x06\x33\x0e\x3f\xd0\x1a\xfa\xbe\x51\xca\x18\xbf\xa1\x7c\x3d\x3e\x59\x12\x04\x3f\x44\xc6\x6c\xbe\xb6\xfe\xef\x3e\xbc\x93\x53\xbf\xbb\xa4\x56\xbf\x50\x36\x21\x3f\x93\xe8\x25\x3e\xeb\xa6\x92\xbe\x52\x82\x33\xbe\x6b\x63\xf3\x3e\xba\x9e\x38\x3e\x96\x51\x0d\xbf\x35\x7e\xe3\xbe\xed\x0a\x53\x3c\xb6\x5a\x17\xbf\x22\x3f\x51\x3f\xbb\x75\x0d\xbf\x77\x8c\x4a\x3f\x43\xb5\xeb\x3e\xca\x75\x91\x3d\x1f\x80\x63\x3f\xd4\xba\xbe\x3e\x18\xd0\x9d\x3d\x3f\x9b\x73\xbf\xf5\x06\xd2\xbe\x7e\x9e\x23\xbf\x8e\xc4\x1d\x3e\x3f\x8c\x1a\xbf\x83\x5e\x18\x3f\x99\xa4\x36\xbf\x21\xf0\x7d\x3f\x72\x8a\x5d\x3f\x5e\xb0\x78\x3f\x8d\x28\x69\xbd\x1e\x67\x29\xbe\x68\x9f\x08\xbf\x86\xff\x3c\x3f\xdd\x71\x41\xbf\x6f\xff\x6c\xbf\x3c\x05\xe6\xbe\x35\x31\x17\xbf\x72\x00\x31\x3f\x0d\x5b\x7c\x3f\x0c\x0d\xb8\x3e\xd0\xb4\xe4\xbe\x0d\x57\xd0\xbe\x02\x9f\xed\xbe\x04\x4a\x63\xbf\x38\x98\xa6\x3d\x08\x6e\x80\x3d\x8b\xb9\x05\x3f\x07\x78\xc3\x3e\x22\xc5\x1f\xbf\x24\xbc\xbd\xbe\x6e\x8f\xe2\xbd\x4a\x0e\x9f\x3c\x02\x93\x10\x3f\xc6\xd8\x4e\xbf\x87\xa8\x99\xbe\xb0\x9c\x41\xbf\x57\x08\xbb\xbe\xd0\xc4\x47\xbd\x40\xfc\xe2\xbe\xa4\xd9\xfc\x3e\x52\x9e\xa0\x3d\xbc\x0b\x15\xbf\xfb\x25\xfa\xbd\x3b\x08\xbf\x3e\x06\x52\x82\xbe\x4b\x56\xac\xbd\x29\x7f\x92\x3e\xba\x03\x72\xbf\x4a\x7f\x8e\xbe\x0c\xbc\xce\x3e\xdf\x48\x3c\xbf\x4a\x52\x24\x3f\x67\xf9\x04\x3f\x24\x4d\x26\x3f\x3b\xd9\x3e\xbf\x38\xb6\x7e\x3f\xd5\x35\x48\x3f\xf5\xd0\x0b\xbf\xfd\x9c\x31\x3f\x3b\xbd\x70\x3f\x0f\x36\xf4\xbe\x7d\xf4\x90\xbd\xa9\x08\x66\xbf\xaa\x7b\x78\xbe\xf3\x72\x6d\x3f\x4f\x6f\x8a\x3e\x93\x9b\x78\x3f\xf7\xbf\x5c\xbd\x6e\xb4\x46\x3f\xf7\xf5\x26\x3f\x78\xe9\xfb\xbe\xdc\x35\xa3\xbc\xbd\x95\x73\xbd\x39\xde\xd8\xbe\x7f\x90\x7b\xbd\x1b\x41\xc4\x3e\x3b\x8e\x00\x3f\x34\x8a\xfe\xbe\x58\xb0\x30\xbf\x1e\xd9\x50\x3f\xc1\xbf\xa0\x3e\x43\xaf\x79\x3f\x6d\x4c\x18\xbe\x90\x92\x55\x3e\xee\x9f\x83\x3e\x16\x25\x6f\xbf\x40\x9e\xbf\xbe\x8d\xe5\x11\x3f\xb9\x4b\x78\x3f\x73\xe2\x22\xbf\xb5\x0f\x9c\xbe\x6c\x44\x81\x3e\x27\x03\xd9\x3e\x10\x47\xe5\xbe\x4f\x1a\x6f\xbf\x14\x72\x48\xbd\xf0\x32\x99\x3e\xca\x17\x3a\xbf\x36\x96\x94\xbd\x79\x9d\xe9\x3e\x22\xda\x22\xbe\x91\x05\x4f\x3f\x0d\xcb\x62\x3f\x28\x44\x3d\xbe\xc2\x4a\x6e\xbf\xa9\x71\x39\xbe\x6b\x3c\x02\x3e\x99\x67\x1b\x3f\x1d\x52\x09\xbf\xe3\x49\xad\x3e\x3e\xdd\x63\xbd\x6e\xfd\x6e\xbe\xde\xc0\x3c\xbf\x1f\x14\x7a\xbf\xfa\x74\x61\xbe\x87\xe7\x2a\xbf\x0e\xa3\x4b\xbf\x88\x44\xf8\xbe\x05\x19\x1b\x3e\x73\xaa\x6d\xbf\xec\x35\xfa\x3d\x5e\x3e\xc4\xbd\xab\x82\xab\xbc\xb7\xca\x28\xbf\xbb\x92\x6b\xbf\x52\x21\xe1\xbe\xe7\x5c\x50\xbf\x94\xb4\x66\xbf\xca\x91\x52\x3e\xc4\x2b\x03\x3f\xe1\xe5\xcc\xbe\xba\xad\xd7\xbe\x87\x62\x4f\xbe\x1d\x0f\x23\x3d\x0a\x0e\x0d\xbf\x76\x0d\xc3\x3d\x04\x95\x61\x3e\xce\xde\x28\xbf\xee\x87\x5f\xbd\xf9\xb8\x57\xbe\x89\x9d\x93\xbe\x67\xb9\x59\xbf\x34\x2d\xb2\xbe\x5e\xfd\x27\x3d\xa7\xbe\x5b\x3f\x1e\x3f\x01\x3f\xe4\xb0\x6f\x3f\x91\x24\x7e\x3e\x3a\xb0\x67\x3e\x43\xa1\xeb\xbe\x18\x48\x01\x3e\x1e\x68\x35\x3f\xd9\xec\x14\x3f\x6c\x82\x4a\xbf\xbd\xf8\xdb\xbe\xac\x8a\x63\xbe\x22\x37\x68\x3e\xa7\xec\xd2\x3e\x43\xf7\x97\x3e\xf0\x2f\x48\xbf\x85\xda\x2d\xbf\x59\xe2\x8b\x3e\x74\xb4\x77\x3e\xf0\xd1\x14\xbf\xcb\x63\xfd\x3e\x1a\x05\x60\x3f\x78\x81\x08\xbf\xb3\xac\xfa\xbd\x78\x87\x2e\x3f\x7f\x4c\x12\xbf\x61\x01\xba\x3e\x50\xc6\x67\xbf\x91\x06\xb0\x3e\x87\x19\x08\xbf\x2d\x1f\x45\x3f\x6f\x08\x4d\x3f\x5e\x43\x4d\x3f\x7e\x15\x77\xbf\x64\x06\x23\xbd\x41\x0a\x5d\x3f\x9c\xf7\x98\xbe\x6b\x52\x21\x3e\xce\x7f\x4d\xbf\xcb\xbc\x87\x3e\x90\xab\x34\xbf\x4b\x26\x6e\xbf\xe8\xfb\x3c\xbe\x66\xf4\x9c\xbe\x51\x29\x38\xbf\xa6\x6e\x5c\xbf\x43\x80\xad\x3e\x61\xa4\x3c\x3f\x7f\xb1\x9e\x3e\x09\x92\x99\x3d\xee\xcd\x76\xbf\x61\x6c\x55\xbf\xa0\xd9\x78\xbd\x7c\x73\x93\x3e\x3b\x2d\x21\x3f\x99\x4a\x00\x3f\x9a\xf6\x25\x3f\x43\x89\x19\x3f\xa6\xba\xaf\xbe\xb4\x1c\x76\x3f\x3f\x8f\xfd\xbe\x1a\x5f\x5a\x3f\x77\x31\xf3\xbe\x1b\xe7\x8a\x3e\xf7\xb4\xdf\x3e\x10\x17\x63\xbf\xe4\x93\x74\x3e\xd7\x77\x04\xbf\x14\x95\x62\xbf\x0d\x2c\x73\x3f\xaf\xda\x66\x3f\x18\x6f\x4d\xbe\x71\x60\x81\xbe\x2e\x64\xf6\x3e\xf5\x23\x38\xbf\x8c\xe5\xa5\x3d\x69\xba\x7b\xbf\xb2\x34\xce\x3e\x3e\x68\x42\x3f\x20\x53\xf4\x3e\x66\xa9\x52\xbf\x4e\x8b\x21\xbf\xfe\x6d\xcb\xbe\x79\xdc\x46\xbf\xff\x0d\x58\xbf\x33\x35\x65\xbf\x0a\x0b\x4e\x3f\x19\x93\xcb\x3e\xc4\xf5\xc0\xbd\xcb\xa5\x64\x3f\x34\x56\x40\xbf\xfe\x8c\xd2\xbe\xa2\x1b\x21\x3f\x5c\x85\x3d\x3e\x97\x91\xc1\xbe\xc4\x5b\x7d\x3f\xc2\xa8\x8c\xb9\x43\x37\x3b\x3f\xac\x5d\x40\x3f\x0d\xc3\xc4\xbe\x55\x1f\x60\xbf\x41\x9b\x27\xbf\xd9\x30\x2a\xbf\x6f\x21\x24\xbe\xd7\xf3\x4d\x3e\xc9\x42\x68\x3f\x72\xc0\x41\xbf\xad\x1d\x70\xbf\x1a\x36\xf3\xbd\xf8\x5e\x67\x3e\x24\x59\x0b\x3e\x9b\x10\xeb\x3b\xbe\xfa\x52\xbf\xd0\x8a\xb6\x3e\x80\xa8\x9b\x3e\xf2\xfd\xa6\xbe\x6f\xd3\x6b\xbf\xc0\x6d\x8e\xbe\xf7\x8c\x2f\xbf\xf5\x40\xaf\xbe\x1b\x43\x11\x3e\xf7\xf6\x56\xbd\x87\xfc\x12\x3f\xaa\xa5\xb5\x3e\xa1\x94\xa7\xbe\x20\x3d\x0b\xbe\xba\x7e\x89\xbc\x66\xb6\xd2\x3e\x17\x21\x51\xbf\x61\xfe\x42\x3f\x0b\xcf\xd1\xbe\x73\x59\x49\x3f\x5d\x31\xe9\xbe\x4a\x22\x64\x3f\x89\xe4\x3a\xbe\x7b\xd8\x14\x3f\x3c\x6e\x92\x3e\xb5\x5c\xdd\x3e\xd1\x0b\xd8\xbd\x3d\x59\x14\xbe\x7a\xba\x34\x3e\xf5\xdb\xba\xbe\x34\xed\x32\xbf\x65\x12\x9d\x3e\xd6\x48\xf5\x3e\xb0\xfd\xf0\x3e\x09\xe7\x34\xbe\x8c\xdf\x44\x3f\x3d\x9d\x7c\xbf\x8b\x05\x34\x3e\x9c\x0d\x69\xbe\x4e\x5a\x24\xbf\xa7\x9f\x36\x3f\x3e\x70\xee\xbe\x0b\xd1\x5e\x3d\x98\xd2\x0e\x3e\xe3\x67\x97\xbd\x48\xd8\x1b\x3d\x69\x3d\x7f\xbe\x5c\x49\xda\x3d\x7c\x5a\x40\xbf\xa9\x6c\x21\xbe\xd8\x25\x7f\x3e\xab\x2d\x67\x3f\x9c\x36\x56\xbf\x20\xf2\x2a\xbe\x62\x05\x8f\xbe\x34\xd8\xb9\xbe\xe6\x63\x3e\x3e\x16\x74\x0e\x3f\xde\x8c\x0d\x3f\x7b\x4e\x02\xbf\xba\xb5\x5f\x3f\xb9\xf3\x46\xbe\x36\xc7\x08\x3f\x67\x4f\x12\xbe\x0d\x4f\x40\x3e\x68\x74\x75\x3f\x9b\x6f\xd4\xbe\x92\xb8\x39\x3d\x03\xfd\x12\xbe\x18\x57\x24\xbf\xee\x80\xeb\x3e\x88\x88\xa9\xbd\x81\x37\x2d\xbf\x65\xa2\x36\xbf\x10\xd4\x75\x3f\xbc\x0a\xb0\xbe\x09\xe3\x50\x3f\x61\xa6\xec\x3e\xbc\x9b\x61\xbe\xa4\xa5\x55\x3f\x3b\x97\x28\xbf\x11\x0c\x14\xbf\xb0\xb3\x75\x3f\x66\xe8\xec\x3e\x81\xb4\x72\xbf\xa5\xce\x64\xbf\x0d\xff\x2a\x3e\xfd\x35\x3d\xbf\x4f\x8e\x8c\x3e\x3a\xa1\x21\x3f\x64\x16\x32\xbf\x8d\x98\xe5\x3e\x61\x8e\x5f\xbf\xdb\xfa\x6e\x3f\x09\xb5\xef\xbd\x11\xbb\xf7\xbe\xb8\xef\xd1\x3d\xe1\x1e\xa0\x3e\x93\xa4\x35\x3e\x3c\xc1\x6e\x3f\xbd\x60\xe7\x3e\xde\xc5\x30\x3f\x97\x92\xe0\xbe\x20\x19\x0f\x3d\x68\x2b\x11\xbe\x1a\xf0\x11\x3f\xf2\xf9\x06\xbc\x86\x3b\xb3\xbe\x40\x81\xa4\x3e\x14\x1d\x91\xbe\x7b\x8d\x6e\xbf\xd3\x4d\x5e\x3f\xf1\xc3\x59\xbf\x0c\x14\x0c\xbf\xfe\xd0\x46\xbf\xb1\xef\x23\xbf\xe8\x7c\x52\xbf\xda\xc0\x05\x3e\x8d\x82\x23\xbf\xcf\x01\x72\x3f\xa0\xae\x6d\x3f\xe7\x4c\x99\xbb\xfc\xed\xea\xbc\x22\xfb\x47\xbf\x20\x6a\x09\xbf\x1f\x16\x28\xbf\x17\x76\x3f\x3e\xa2\xd5\x10\xbf\xf5\xe0\x66\xbf\x2a\x04\x8e\x3c\x9b\xce\xa8\x3e\x2f\x18\xb2\xbe\xa8\x74\x49\x3f\x74\xa9\x7f\x3e\x7a\x2e\xdf\xbe\xa7\x2d\x33\x3f\x3a\x8e\x96\x3e\x6f\x22\x62\xbf\x40\xc1\x55\x3e\xb1\x99\x74\x3f\x0f\xce\x56\xbe\x61\xfd\x80\xbe\xfc\x44\x8e\x3e\x8e\xbd\x55\x3e\x28\xa9\xaa\xbe\x64\xef\x2f\xbf\x8a\x0c\xb9\x3d\xf2\xec\x1d\xbf\x8f\x6d\x68\xbf\xe1\xd7\x35\xbf\x13\xaa\xec\x3d\x9a\x49\x4b\xbf\x65\xd4\x5b\x3f\xf8\xd6\x38\xbf\xb6\x10\x20\x3f\x3d\xb0\x28\x3f\xe6\x34\xe0\x3e\x25\x9c\xe8\xbe\xaa\xa6\x43\xbf\xea\xc6\x45\xbf\x77\x5c\x21\xbe\x7f\xb3\xe8\x3e\x0f\xb5\x36\x3d\xb4\x2c\x7d\x3f\x03\xc3\x21\x3f\x7b\x39\x82\x3e\xc2\x96\x2b\xbf\x98\x46\x61\xbf\x6e\x82\x2f\xbe\xc4\x1e\x69\xbf\x7b\x6c\xcc\x3e\x44\xf7\x77\x3f\x40\x31\xa3\xbc\x64\xb9\x64\xbf\x1f\x35\x5e\xbf\x56\x22\x46\x3f\xc7\xb1\x08\xbe\x02\x09\x7c\xbf\x22\x51\xcb\xbd\x1d\xe9\x81\xbe\xa5\x0b\x5f\xbf\xe2\x4c\x29\xbf\x87\x6f\x7c\xbf\x8c\x70\x56\x3f\x58\xf8\x95\xbe\xdb\xe8\x6d\xbf\x55\x5f\x50\xbf\x77\xea\x6e\xbf\x96\x44\x5d\xbe\x84\xb4\xcc\x3e\x29\x8b\xb9\xbe\x6f\xe1\x02\x3f\x01\xdc\x3a\xbe\x9a\xb9\xee\x3e\xe7\x32\x25\xbe\x10\x9a\xd4\x3e\xda\x9e\x86\x3c\xb3\x94\x23\xbf\x61\xa3\x4b\x3f\xcd\x6f\x7d\xbf\xf2\x41\x01\xbe\xe8\xf7\x03\xbb\x82\x8b\xe5\xbe\xac\x92\x72\x3d\x5f\xac\x7a\x3f\xc6\x5d\x53\x3d\x76\xd0\xd5\x3d\x6a\x8e\x42\x3f\x9e\xfb\x0e\xbf\xc2\x89\x6b\xbf\xd4\xa3\x68\x3f\x91\x55\x54\xbf\x23\xe8\x6e\xbf\x12\x50\x11\xbf\xa2\x21\x45\xbe\x8c\x43\x35\x3f\x05\x1d\x98\xbd\xe2\xc8\x14\x3f\xb2\x9f\x68\x3f\xff\x07\x16\x3f\x6e\xa7\x4f\xbf\x15\xc2\x84\x3d\xac\xb3\x76\xbe\xc1\x19\x1a\xbe\x9b\x23\xa4\xbd\x78\x18\x82\x3e\x06\xff\x72\xbf\xa5\x8d\x75\x3e\xc5\xa3\x5f\xbf\x3d\xa3\x33\x3e\x9b\x4c\x3f\xbf\x24\x78\x8c\x3e\x7c\xbd\x61\xbf\xda\xb2\x11\x3f\x46\x07\x04\xbf\x2a\x74\x27\x3f\x2e\x11\x08\x3f\xf6\xbc\xcf\xbe\xc7\x5e\x4d\xbf\x17\xba\x8d\x3e\x66\x3d\x32\x3f\xbd\x03\x91\xbe\x67\x90\x6a\xbf\x19\x44\x01\xbf\xd7\xc1\x08\x3f\xb4\x29\xc8\x3b\x5c\xc9\x37\x3f\x22\x18\x7b\x3f\x60\xf4\x6b\xbe\x97\x7d\x61\x3f\x36\x75\xab\x3e\xff\x34\x59\xbd\x5f\xf5\xcf\x3c\xd0\x9a\xc5\xbe\x3f\xe7\x6f\xbe\x5d\x64\x7d\x3f\x8f\x23\xda\xbe\xd0\x7f\x1c\xbf\xc6\xd1\x70\x3c\x22\x90\x29\xbd\xa2\x30\x3c\xbf\x2f\x0f\xaa\xbe\x24\xea\x75\xbf\x41\xaa\x77\x3f\x86\xd8\x37\xbf\x98\xb8\x80\xbe\xb5\xce\x1f\xbf\xb5\x30\x93\xbe\x99\x5d\xb9\xbd\xba\x3b\x1a\xbe\x4d\x1e\x13\xbf\x6c\xf0\x16\xbf\xbd\x9f\x64\xbf\x51\xf6\x56\x3f\xa7\xe4\xd7\xbd\x1c\x02\x29\xbe\xc0\x6b\x72\xbf\xfe\x9c\x5c\x3f\xe3\x41\x5b\xbf\xdc\x22\x0e\x3f\x9b\xea\x4c\x3f\x23\x3f\xca\x3d"
local SNK_TEST_VECTOR = "\x00\x00\x00\x00\xe1\x43\x04\xbb\x98\x91\x5a\x3b\xa3\x4a\xf5\x3a\x59\x30\xdd\x3b\xe9\x1a\xe6\x3b\xd9\xec\xa3\x3b\x71\x9b\x32\x3c\x19\xda\xec\x3c\xa6\x59\xdd\x3b\x4e\x5a\xb4\x3c\x2b\xcf\xae\x3b\x8f\x32\x34\x3c\x33\xb3\x5a\x3c\x9b\x87\x57\x3c\x4e\x96\x32\x3b\xa7\x24\xe5\xba\xc7\x31\x6e\xbb\x52\x8b\x71\x3b\xb3\x11\xc8\xbc\xa6\xf3\xb7\x3c"

describe("top level test", function ()
    --[[
            [ Source ] -- [ Mul. Conj. ] -- [ LPF ] -- [ Freq. Discrim. ] -- [ Decimator ] -- [ Sink ]
                                |
                                |
                            [ Source ]
    --]]

    for _, multiprocess in pairs({true, false}) do
        it("run " .. (multiprocess and "multiprocess" or "singleprocess"), function ()
            -- Prepare our source and sink file descriptors
            local src1_fd = buffer.open(SRC1_TEST_VECTOR)
            local src2_fd = buffer.open(SRC2_TEST_VECTOR)
            local snk_fd = buffer.open()

            -- Build the pipeline
            local top = radio.CompositeBlock()
            local src1 = radio.FileIQDescriptorSource(src1_fd, 'f32le', 1000000)
            local src2 = radio.FileIQDescriptorSource(src2_fd, 'f32le', 1000000)
            local b1 = radio.MultiplyConjugateBlock()
            local b2 = radio.LowpassFilterBlock(16, 100e3)
            local b3 = radio.FrequencyDiscriminatorBlock(5.0)
            local b4 = radio.DecimatorBlock(15e3, 25, {num_taps = 16})
            local snk = radio.FileDescriptorSink(snk_fd)
            top:connect(src1, 'out', b1, 'in1')
            top:connect(src2, 'out', b1, 'in2')
            top:connect(b1, b2, b3, b4, snk)
            top:run(multiprocess)

            -- Rewind the sink buffer
            buffer.rewind(snk_fd)

            -- Read the sink buffer
            local buf = buffer.read(snk_fd, #SNK_TEST_VECTOR*2)
            assert.is.equal(#SNK_TEST_VECTOR, #buf)

            -- Deserialize actual and expected test vectors
            local actual = radio.Float32Type.deserialize(buf, #SNK_TEST_VECTOR/4)
            local expected = radio.Float32Type.deserialize(SNK_TEST_VECTOR, #SNK_TEST_VECTOR/4)

            jigs.assert_vector_equal(expected, actual, 1e-6)
        end)
    end
end)
