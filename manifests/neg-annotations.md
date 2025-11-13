Enable container-native load balancing by annotating Services:

```
metadata:
  annotations:
    cloud.google.com/neg: '{"ingress": true}'
```
This registers Pod backends as NEGs, letting the LB send traffic directly to Pods and preserve client IP.
