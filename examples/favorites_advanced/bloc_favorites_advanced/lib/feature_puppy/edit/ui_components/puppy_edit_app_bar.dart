import 'package:bloc_sample/feature_puppy/edit/bloc/puppy_edit_form_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class PuppyEditAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PuppyEditAppBar({
    required bool enabled,
    void Function()? onSavePressed,
    required this.puppyEditFormBloc,
    Key? key,
  })  : _enabled = enabled,
        // _onSavePressed = onSavePressed,
        super(key: key);

  final bool _enabled;
  // final void Function()? _onSavePressed;
  final PuppyEditFormBloc puppyEditFormBloc;

  double get loadingIndicatorSize => 24;

  @override
  Widget build(BuildContext context) =>
      AppBar(title: const Text('Edit Puppy'), actions: [
        _buildSaveButton(),
      ]);

  Widget _buildSaveButton() => BlocBuilder<PuppyEditFormBloc, FormBlocState>(
        builder: (context, state) {
          if (state is FormBlocSubmitting) {
            //emitSubmitting() changes the state to FormBlocSubmitting
            // print('_buildSaveButton FormBlocSubmitting1
            // ${state.runtimeType}');
            return _buildLoading();
          }
          // else if (state.canSubmit){
          // print('_buildSaveButton state.canSubmit ${state.canSubmit}');
          // return _buildIcon();
          // }
          // print('_buildSaveButton state.canSubmit ${state.canSubmit}');
          return _buildIcon();
        },
      );

  Widget _buildIcon() => IconButton(
        icon: Icon(
          Icons.save,
          color: _enabled ? Colors.white : Colors.grey,
        ),
        onPressed: () {
          if (_enabled) {
            // print('_onSavePressed?.call()');
            // puppyEditFormBloc.state.canSubmit;
            // print('puppyEditFormBloc.state.: ${puppyEditFormBloc
            //     .state.runtimeType}');
            // print(
            //     'puppyEditFormBloc.state.canSubmit ${puppyEditFormBloc
            //         .state.canSubmit}');
            // puppyEditFormBloc.state._isValidByStep;
            puppyEditFormBloc.submit();
            // _onSavePressed!();
            // _onSavePressed?.call();
          }
        },
      );

  Widget _buildLoading() => IconButton(
        icon: Container(
          width: loadingIndicatorSize,
          height: loadingIndicatorSize,
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        onPressed: () {},
      );

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
