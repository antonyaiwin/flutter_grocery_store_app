import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/screens/add_address_screen_controller.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provider = context.read<AddAddressScreenController>();
    return Form(
      key: provider.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(top: 10),
            child: Text(
              'Enter complete address',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Divider(
            height: 1,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextFormField(
                    controller: provider.nameController,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Your name *',
                    ),
                    validator: (value) {
                      if (value == null || value.length < 5) {
                        return 'Enter a valid name!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: provider.flatController,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Flat / House no / Building name *',
                    ),
                    validator: (value) {
                      if (value == null || value.length < 5) {
                        return 'Enter a address!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: provider.floorController,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Floor (optional)',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    enabled: false,
                    controller: provider.locationController,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Location',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: provider.landmarkController,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Landmark (optional)',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: provider.phoneNoController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Phone number (optional)',
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                provider.saveAddress();
              },
              child: const Center(
                child: Text('Save Address'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
