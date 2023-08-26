class UserDetails {
  final String aadharNumber;
  final String name;
  final int dobMillis;
  final String gender;
  final String contactNumber;
  final List<Appointment> appointments; 

  UserDetails({
    required this.aadharNumber,
    required this.name,
    required this.dobMillis,
    required this.gender,
    required this.contactNumber,
    required this.appointments
  });
}

class Appointment{
  final int appointmentId;
  final bool completed;

  Appointment({
    required this.appointmentId,
    required this.completed
  });
}