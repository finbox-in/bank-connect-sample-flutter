class FinBoxJourneyResult {

  String entityId;
  String linkId;
  String message;
  String errorType;


  FinBoxJourneyResult(this.entityId,this.linkId,this.message,this.errorType);

  factory FinBoxJourneyResult.fromJson(dynamic json) {
    return FinBoxJourneyResult(json['entityId'] as String, json['linkId'] as String,
        json['message'] as String, json['errorType'] as String );
  }

  @override
  String toString() {
    return '{ $entityId, $linkId,$message, $errorType }';
  }
}