import 'package:final_depi_project/features/address/data/models/address_model.dart';

abstract class AddressState {}

class AddressInitialState extends AddressState {}

class AddAddressLoadingState extends AddressState {}

class AddAddressSuccessState extends AddressState {
  final String message;
  AddAddressSuccessState(this.message);
}

class AddAddressErrorState extends AddressState {
  final String error;
  AddAddressErrorState(this.error);
}

class GetAddressesLoadingState extends AddressState {}

class GetAddressesSuccessState extends AddressState {
  final List<Address> addresses;
  GetAddressesSuccessState(this.addresses);
}

class GetAddressesErrorState extends AddressState {
  final String error;
  GetAddressesErrorState(this.error);
}

class GetAddressByIdLoadingState extends AddressState {}

class GetAddressByIdSuccessState extends AddressState {
  final Address address;
  GetAddressByIdSuccessState(this.address);
}

class GetAddressByIdErrorState extends AddressState {
  final String error;
  GetAddressByIdErrorState(this.error);
}

class RemoveAddressLoadingState extends AddressState {}

class RemoveAddressSuccessState extends AddressState {
  final List<Address> addresses;
  RemoveAddressSuccessState(this.addresses);
}

class RemoveAddressErrorState extends AddressState {
  final String error;
  RemoveAddressErrorState(this.error);
}

class UpdateAddressLoadingState extends AddressState {}

class UpdateAddressSuccessState extends AddressState {
  final String message;
  UpdateAddressSuccessState(this.message);
}

class UpdateAddressErrorState extends AddressState {
  final String error;
  UpdateAddressErrorState(this.error);
}
