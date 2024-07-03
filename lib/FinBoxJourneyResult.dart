class FinBoxJourneyResult {

  String? entityId;
  String? linkId;
  String? message;
  String? errorType;
  String? sessionId;


  FinBoxJourneyResult(this.entityId,this.linkId,this.message,this.errorType,this.sessionId);

  factory FinBoxJourneyResult.fromJson(dynamic json) {
    return FinBoxJourneyResult(json['entityId'] as String?, json['linkId'] as String?,
        json['message'] as String?, json['errorType'] as String?, json['sessionId'] as String?);
  }

  @override
  String toString() {
    return '{ ${this.entityId}, ${this.linkId},${this.message}, ${this.errorType}, ${this.sessionId}';
  }
}