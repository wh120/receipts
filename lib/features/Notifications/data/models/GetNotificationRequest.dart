class GetNotificationRequest {
  int skipCount;
  int maxResultCount;
  String sorting;

  GetNotificationRequest({this.skipCount, this.maxResultCount, this.sorting});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.skipCount !=null) data['SkipCount'] = this.skipCount;
    if(this.maxResultCount !=null) data['MaxResultCount'] = this.maxResultCount;
    if(this.sorting !=null) data['Sorting'] = this.sorting;
    return data;
  }
}
