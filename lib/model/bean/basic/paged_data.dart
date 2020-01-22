class PagedData<T> {

  int total;
  List<T> rows;

  PagedData.empty(){
    this.total = 0;
    this.rows = <T>[];
  }

}
