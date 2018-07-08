#!/bin/bash

ansible testserver -m ping

ansible testserver -m command -a uptime

ansible testserver -s -m yum -a list=installed