
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
}
