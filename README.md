# Flutter BankConnect

The plugin can be used to integrate mobile apps with BankConnect.

NOTE

Following will be shared by FinBox team at the time of integration:

- `ACCESS_KEY`
- `SECRET_KEY`
- `BC_SDK_VERSION`
- `CLIENT_API_KEY`



## Add Plugin

Specify the following in `local.properties` file:

```properties
ACCESS_KEY=<ACCESS_KEY>
SECRET_KEY=<SECRET_KEY>
BC_SDK_VERSION=<SDK_VERSION>
```

Add plugin dependency in `pubspec.yaml` file:

 ```yaml
 finbox_bc_plugin: any
 ```

## Init Library in Kotlin Application

## Init SDK

```dart
FinBoxBcPlugin.initSdk("CLIENT_API_KEY","FROM_DATE","TO_DATE","BANK_NAME");
```



## Handle SDK Journey Result

Create a method in dart file to handle this callback.


```dart
static Future<void> _getJourneyResult(MethodCall call) async {
if (call.method == 'getJourneyResult')
    {var json=call.arguments}
}
```
Following json will be received
```json
{"entityId":"entity_id","linkId":"link_id","error_type":"error_code","message":"msg"}
```

## Error Codes

Below table contains the error codes and the description:

error_type | Description |
--- | --- | 
MU002 | Trial Expired for Dev Credentials
MU003 | PDF Password Incorrect
MU004 | Specified bank doesn't match with detected bank
MU006 | Non Parsable PDF - PDF file is corrupted or has no selectable text (only scanned images)
MU020 | Not a valid statement or bank is not supported
MU021 | Invalid Date Range
NB000 | NetBanking Failed
NB003 | Netbanking Login Error
NB004 | Captcha Error
NB005 | Security Error 
