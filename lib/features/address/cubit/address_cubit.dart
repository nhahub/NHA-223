import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:final_depi_project/features/address/cubit/address_states.dart';
import 'package:final_depi_project/features/address/data/repo/address_repo.dart';
import 'package:final_depi_project/features/address/data/models/address_model.dart';
import 'package:final_depi_project/core/shared_prefrences.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepository addressRepository;

  List<Address> addresses = [];

  Address? selectedAddress;

  String? deletingId;

  AddressCubit(this.addressRepository) : super(AddressInitialState());

  Future<void> addAddress({
    required Map<String, dynamic> addressData,
    String? token,
  }) async {
    emit(AddAddressLoadingState());
    try {
      final usedToken =
          token ?? AppSharedPreferences.getString(SharedPreferencesKeys.token);

      if (usedToken == null || usedToken.isEmpty) {
        throw Exception('No token found, please login again');
      }

      final response = await addressRepository.addAddress(
        addressData: addressData,
        token: usedToken,
      );

      final message = response.data["message"] ?? "Address added successfully";

      emit(AddAddressSuccessState(message));

      await getAddresses(token: usedToken);
    } catch (e) {
      emit(AddAddressErrorState(e.toString()));
    }
  }

  Future<void> getAddresses({String? token}) async {
    emit(GetAddressesLoadingState());

    try {
      final usedToken =
          token ?? AppSharedPreferences.getString(SharedPreferencesKeys.token);

      if (usedToken == null || usedToken.isEmpty) {
        throw Exception('No token found, please login again');
      }

      final response =
          await addressRepository.getAllAddresses(token: usedToken);

      print("📥 Addresses response: ${response.data}");

      final result = AddressesResponse.fromJson(response.data);

      addresses = result.data;

      emit(GetAddressesSuccessState(addresses));
    } catch (e) {
      print("❌ Error in getAddresses: $e");
      emit(GetAddressesErrorState(e.toString()));
    }
  }

  Future<void> getAddressById(String id, {String? token}) async {
    emit(GetAddressByIdLoadingState());

    try {
      final usedToken =
          token ?? AppSharedPreferences.getString(SharedPreferencesKeys.token);

      if (usedToken == null || usedToken.isEmpty) {
        throw Exception('No token found, please login again');
      }

      final response = await addressRepository.getAddressById(
        id: id,
        token: usedToken,
      );

      print("📥 GetById response: ${response.data}");

      final result = AddressesResponse.fromJson(response.data);

      if (result.data.isEmpty) {
        throw Exception('Address not found');
      }

      selectedAddress = result.data.first;

      print(
          "✅ Selected address: ${selectedAddress!.id} - ${selectedAddress!.name}");

      emit(GetAddressByIdSuccessState(selectedAddress!));
    } catch (e) {
      print("❌ Error in getAddressById: $e");
      selectedAddress = null;
      emit(GetAddressByIdErrorState(e.toString()));
    }
  }

  Future<void> removeAddress(String id) async {
    try {
      deletingId = id;
      emit(RemoveAddressLoadingState());

      final token =
          AppSharedPreferences.getString(SharedPreferencesKeys.token);

      if (token == null || token.isEmpty) {
        throw Exception('No token found, please login again');
      }

      final response = await addressRepository.removeAddress(
        id: id,
        token: token,
      );

      print("📥 Remove response data: ${response.data}");

      final result = AddressesResponse.fromJson(response.data);

      addresses = result.data;

      emit(RemoveAddressSuccessState(addresses));
    } catch (e) {
      print("❌ Error in removeAddress: $e");
      emit(RemoveAddressErrorState(e.toString()));
    } finally {
      deletingId = null;
    }
  }

  Future<void> updateAddress({
    required String id,
    required Map<String, dynamic> addressData,
    String? token,
  }) async {
    emit(UpdateAddressLoadingState());

    try {
      final usedToken =
          token ?? AppSharedPreferences.getString(SharedPreferencesKeys.token);

      if (usedToken == null || usedToken.isEmpty) {
        throw Exception('No token found, please login again');
      }

      final response = await addressRepository.updateAddress(
        id: id,
        addressData: addressData,
        token: usedToken,
      );

      print("📥 Update response data: ${response.data}");

      final message =
          response.data["message"] ?? "Address updated successfully";

      await getAddresses(token: usedToken);

      try {
        selectedAddress =
            addresses.firstWhere((address) => address.id == id);
      } catch (_) {
        selectedAddress = null;
      }

      emit(UpdateAddressSuccessState(message));
    } catch (e) {
      print("❌ Error in updateAddress: $e");
      emit(UpdateAddressErrorState(e.toString()));
    }
  }
}
