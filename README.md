b3
==

bootstrap 3 less files with meteor style javascript.

##API

b3 is the exported handle.

###Alerts

format  
```coffeescript

     b3.alert#{type} text, options

```


Alerts may be of standardi Bootstrap3 types:

- danger
- success
- info
- warning

and may be positioned in any of 9 regional 'b3AlertList' containers

-topRight
-middleRight
-bottomRight
-topCenter
-middleCenter
-bottomCenter
-topLeft
-middleLeft
-bottomLeft

``coffeescript

     b3.alertSuccess "This is a success alert.", { layout: 'bottomLeft' }

     b3.alertDanger "This is an danger alert.", { header: 'Error.', layout: 'topRight' }

```

