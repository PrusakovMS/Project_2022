#!/bin/bash

TOKEN='5393517484:AAHE8cvXA25p-JlehVENxgtu1K5RJ00-AzA'
CHATID='752707286' 

curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendVideo -F chat_id=${CHATID} -F video="@couette.mp4"
