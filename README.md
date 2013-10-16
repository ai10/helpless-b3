b3-helpless
==

bootstrap 3 less files with meteor style javascript.

##API

b3 is the exported handle.

###dynaSign

An inline navbar widget for dynamically interacting with user.

add keys.coffee file with a  mailgun.com public-api-key for e-mail validation.

```coffeescript
@b3.validate_api_key = '<mailgun.com public-api-key>'
```
Insert into your navbar.

```handlebars

<ul class="nav navbar-nav navbar-right">
  {{> dynaSign}}
</ul>

```


###Alerts
  
```coffeescript

b3.alert{type} text, options

```

#### Alert Types

Alerts may be of standardi Bootstrap3 types:

* danger
* succes
* info
* warning

#### Alert _region_ option default 'topRight'
##### may be any of 9 regional 'b3AlertList' containers

* topRight
* middleRight
* bottomRight
* topCenter
* middleCenter
* bottomCenter
* topLeft
* middleLeft
* bottomLeft

```coffeescript
b3.alertSuccess "This is a success alert.", { region: 'bottomLeft' }

b3.alertDanger "This is an danger alert.", { header: 'Error.', region: 'topRight' }
```

#### Alert _hover_ option  default - false
##### when _hover_ option is set to true the alert is dismisses on mouseover

```coffeescript
b3.alertInfo "This disappears on hover.", { hover: true}
```

#### Alert _timeout_ option default - false
#####if _timeout_ is an integer the alert is removed after _timeout_ millisecs

```coffeescript
b3.alertSuccess "This is removed after 4 seconds", { timeout: 5000 }
```

#### Alert _alarm_ option default - false
##### if _alarm_ is an integer a _ringing_ class is added afert _alarm_ millisecs

```coffeescript
b3.alertSuccess "This has a new class 'ringing' after 2 seconds.", {
    alarm: 2000
    ringing: 'ringing'
}

```
