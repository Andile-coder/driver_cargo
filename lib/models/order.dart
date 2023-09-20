class Orders {
  String? order_id;
  String? user_id;
  String? driver_id;
  String? order_number;
  String? parcel_name;
  String? required_temp;
  String? pickup_address;
  String? droppoff_address;
  String? pickup_date;
  String? status;

  Orders({
    this.order_id,
    this.user_id,
    this.driver_id,
    this.order_number,
    this.parcel_name,
    this.required_temp,
    this.pickup_address,
    this.droppoff_address,
    this.status,
    this.pickup_date,
  });
  void fromJson(Map<dynamic, dynamic> json) {
    user_id = json["user_id"];
    driver_id = json["driver_id"];
    order_number = json["order_number"];
    parcel_name = json["parcel_name"];
    required_temp = json["required_temp"];
    pickup_address = json["pickup_address"];
    droppoff_address = json["droppoff_address"];
    pickup_date = json["pickup_date"];
    status = json["status"];
  }
}


//   {order_id: 03b2bfc5-3307-4d62-9276-6511aed78476, user_id: eb49c7ac-6dcc-4375-b96a-9bbdf3395f8d, driver_id: 10177c80-c236-4273-a570-2304117ec8c3, order_number: 3392aba0, parcel_name: test 2, required_temp: 25.5, priority_status: 1, pickup_address:  1 test street, droppoff_address:  1 test street, pickup_date: true, status: BOOKED, createdAt: 2023-09-12T09:43:28.000Z, updatedAt: 2023-09-12T09:53:35.000Z}]
// Reloaded 1 of 1608 libraries in 1 340ms (compile: 112 ms, reload: 462 ms, reassemble: 403 ms).
// I/flutter (32416): [{order_id: 03b2bfc5-3307-4d62-9276-6511aed78476, user_id: eb49c7ac-6dcc-4375-b96a-9bbdf3395f8d, driver_id: 10177c80-c236-4273-a570-2304117ec8c3, order_number: 3392aba0, parcel_name: test 2, required_temp: 25.5, priority_status: 1, pickup_address:  1 test street, droppoff_address:  1 test street, pickup_date: true, status: BOOKED, createdAt: 2023-09-12T09:43:28.000Z, updatedAt: 2023-09-12T09:53:35.000Z}