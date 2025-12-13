import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:boilerplate/features/outfits/suggest_controller.dart';

class OutfitsScreen extends ConsumerWidget {
  const OutfitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestionsState = ref.watch(suggestControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Outfit Suggestions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(suggestControllerProvider.notifier).generateSuggestions();
            },
          ),
        ],
      ),
      body: suggestionsState.when(
        data: (outfits) {
          if (outfits.isEmpty) {
            return const Center(
              child: Text('No outfits found. Add more items to your wardrobe!'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: outfits.length,
            itemBuilder: (context, index) {
              final outfit = outfits[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Score: ${outfit.score} - ${outfit.reason}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 150,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: outfit.items.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, itemIndex) {
                            final item = outfit.items[itemIndex];
                            return Column(
                              children: [
                                Expanded(
                                  child: Image.file(
                                    File(item.localPath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(item.type.name),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.push('/outfits/try-on', extra: outfit.items);
                          },
                          icon: const Icon(Icons.accessibility_new),
                          label: const Text('Try On'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
