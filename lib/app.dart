import 'package:epsi_shop/bo/article.dart';
import 'package:epsi_shop/page/article_detail.dart';
import 'package:epsi_shop/page/cart_page.dart';
import 'package:epsi_shop/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
            path: 'cart',
            builder: (BuildContext context, GoRouterState state) {
              return CartPage();
            }),
        GoRoute(
          path: 'detail',
          builder: (BuildContext context, GoRouterState state) {
            return ArticleDetailPage(
              article: state.extra as Article,
            );
          },
        )
      ],
    ),
  ],
);
