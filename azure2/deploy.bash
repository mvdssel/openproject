#!/usr/bin/env bash

. ~/bin/pause
. ~/bin/colors
. ~/bin/printexec

pause creating plan
az appservice plan create --name huisjeServicePlan --resource-group huisje --sku S1 --is-linux

pause creating webapp via compose
az webapp create --resource-group huisje --plan huisjeServicePlan --name huisje --multicontainer-config-type compose --multicontainer-config-file ./openproject/docker-compose.yml

