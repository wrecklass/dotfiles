#!/bin/bash

getcontainerpods() {
  kubectl get pods "$1" -o jsonpath="{.spec.containers[*].name}"
}
