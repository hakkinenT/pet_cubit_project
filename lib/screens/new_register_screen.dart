import 'package:crud_bloc/cubit/new_pet_validation_cubit.dart';
import 'package:crud_bloc/cubit/pet_cubit.dart';
import 'package:crud_bloc/data/models/pet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewRegisterScreen extends StatelessWidget {
  final Pet? pet;
  const NewRegisterScreen({Key? key, this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider.value(value: BlocProvider.of<PetCubit>(context)),
      BlocProvider(create: (context) => NewPetValidationCubit()),
    ], child: PetFormView(pet: pet));
  }
}

class PetFormView extends StatefulWidget {
  final Pet? pet;
  const PetFormView({Key? key, this.pet}) : super(key: key);

  @override
  State<PetFormView> createState() => _PetFormViewState();
}

class _PetFormViewState extends State<PetFormView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();
  final FocusNode _breedFocusNode = FocusNode();
  String _appBarTitle = 'Cadastrar Pet';
  String _textButton = 'Cadastrar Pet';

  @override
  void initState() {
    if (widget.pet == null) {
      _nameController.text = '';
      _ageController.text = '';
      _breedController.text = '';
    } else {
      _appBarTitle = 'Editar Pet';
      _textButton = 'Editar Pet';
      _nameController.text = widget.pet!.name;
      _ageController.text = widget.pet!.age.toString();
      _breedController.text = widget.pet!.breed;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        leading: IconButton(
            onPressed: () {
              if (_nameController.text != '' ||
                  _ageController.text != '' ||
                  _breedController.text != '') {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Cancelar Cadastro'),
                          content: const Text(
                              'Tem certeza que deseja cancelar a operação?'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Não')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text('Sim'))
                          ],
                        ));
              } else {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.close)),
      ),
      body: BlocListener<PetCubit, PetState>(
        listener: (context, state) {
          if (state is PetInitial) {
            const SizedBox();
          } else if (state is PetLoading) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                });
          } else if (state is PetSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                  content: Text('Operação realizada com sucesso!')));
            Navigator.pop(context);
            context.read<PetCubit>().getAllPets();
          } else if (state is PetLoaded) {
            Navigator.pop(context);
          } else if (state is PetFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  const SnackBar(content: Text('Erro ao atualizar pet')));
          }
        },
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<NewPetValidationCubit, NewPetValidationState>(
                        builder: (context, state) {
                      return TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          border: OutlineInputBorder(),
                        ),
                        controller: _nameController,
                        validator: (value) {
                          if (state is PetValidating) {
                            return state.name?.onError;
                          } else {
                            return null;
                          }
                        },
                        focusNode: _nameFocusNode,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: _ageFocusNode.requestFocus,
                        onChanged: (name) {
                          context.read<NewPetValidationCubit>().validateForm(
                              Pet(
                                  name: _nameController.text,
                                  age: _ageController.text,
                                  breed: _breedController.text));
                        },
                        onFieldSubmitted: (String value) {},
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<NewPetValidationCubit, NewPetValidationState>(
                        builder: (context, state) {
                      return TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Idade',
                          border: OutlineInputBorder(),
                        ),
                        controller: _ageController,
                        validator: (value) {
                          if (state is PetValidating) {
                            return state.age?.onError;
                          } else {
                            return null;
                          }
                        },
                        focusNode: _ageFocusNode,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: _breedFocusNode.requestFocus,
                        onChanged: (age) {
                          context.read<NewPetValidationCubit>().validateForm(
                              Pet(
                                  name: _nameController.text,
                                  age: _ageController.text,
                                  breed: _breedController.text));
                        },
                        onFieldSubmitted: (String value) {},
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<NewPetValidationCubit, NewPetValidationState>(
                        builder: (context, state) {
                      return TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Raça',
                          border: OutlineInputBorder(),
                        ),
                        controller: _breedController,
                        validator: (value) {
                          if (state is PetValidating) {
                            return state.breed?.onError;
                          } else {
                            return null;
                          }
                        },
                        focusNode: _breedFocusNode,
                        textInputAction: TextInputAction.done,
                        onChanged: (name) {
                          context.read<NewPetValidationCubit>().validateForm(
                              Pet(
                                  name: _nameController.text,
                                  age: _ageController.text,
                                  breed: _breedController.text));
                        },
                        onFieldSubmitted: (String value) {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            final pet = Pet(
                                id: widget.pet?.id,
                                name: _nameController.text,
                                age: _ageController.text,
                                breed: _breedController.text);
                            context.read<PetCubit>().savePet(pet);
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: BlocBuilder<NewPetValidationCubit,
                          NewPetValidationState>(builder: (context, state) {
                        return ElevatedButton(
                            onPressed: state is PetValidated
                                ? () {
                                    if (_formKey.currentState!.validate()) {
                                      FocusScope.of(context).unfocus();
                                      final pet = Pet(
                                          id: widget.pet?.id,
                                          name: _nameController.text,
                                          age: _ageController.text,
                                          breed: _breedController.text);
                                      context.read<PetCubit>().savePet(pet);
                                    }
                                  }
                                : null,
                            child: Text(_textButton));
                      }),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
