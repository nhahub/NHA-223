import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:final_depi_project/features/address/cubit/address_cubit.dart';
import 'package:final_depi_project/features/address/cubit/address_states.dart';
import 'package:final_depi_project/features/address/data/models/address_model.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({Key? key}) : super(key: key);

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  String? selectedAddressId;

  @override
  void initState() {
    super.initState();

    final cubit = context.read<AddressCubit>();
    if (cubit.addresses.isEmpty) {
      cubit.getAddresses();
    }
  }

  @override
  Widget build(BuildContext context) {
    final addressCubit = context.read<AddressCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Shipping Address'),
      ),
      body: BlocBuilder<AddressCubit, AddressState>( 
        builder: (context, state) {
          if (state is GetAddressesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetAddressesErrorState) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 40, color: Colors.red),
                  const SizedBox(height: 12),
                  const Text(
                    'حصل خطأ في تحميل العناوين',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    state.error,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      addressCubit.getAddresses();
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          final List<Address> addresses = addressCubit.addresses; 
          if (addresses.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.location_off, size: 50, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'لا يوجد عناوين حتى الآن',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'أضف عنوان جديد من شاشة العناوين',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          if (selectedAddressId == null &&
              addressCubit.selectedAddress != null) {
            selectedAddressId = addressCubit.selectedAddress!.id;
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemBuilder: (context, index) {
                    final address = addresses[index];
                    final isSelected = address.id == selectedAddressId;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedAddressId = address.id;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Radio<String>(
                              value: address.id,
                              groupValue: selectedAddressId,
                              onChanged: (value) {
                                setState(() {
                                  selectedAddressId = value;
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    address.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    address.city,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  if (address.details != null &&
                                      address.details!.isNotEmpty) ...[
                                    const SizedBox(height: 2),
                                    Text(
                                      address.details!,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                  if (address.phone != null &&
                                      address.phone!.isNotEmpty) ...[
                                    const SizedBox(height: 2),
                                    Text(
                                      'موبايل: ${address.phone}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemCount: addresses.length,
                ),
              ),

              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: selectedAddressId == null
                          ? null
                          : () {
                              final selected = addresses.firstWhere(
                                (a) => a.id == selectedAddressId,
                              );

                              addressCubit.selectedAddress = selected;

                              Navigator.of(context).pop<Address>(selected);
                            },
                      child: const Text('تأكيد العنوان'),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
