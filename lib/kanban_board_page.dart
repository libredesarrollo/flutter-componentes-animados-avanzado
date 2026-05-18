import 'package:flutter/material.dart';

// Modelo de datos
class KanbanCard {
  final String id;
  final String title;
  final String priority; // 'alta', 'media', 'baja'
  KanbanCard({required this.id, required this.title, required this.priority});
}

class KanbanBoardPage extends StatefulWidget {
  const KanbanBoardPage({super.key});
  @override
  State<KanbanBoardPage> createState() => _KanbanBoardPageState();
}

class _KanbanBoardPageState extends State<KanbanBoardPage> {
  final Map<String, List<KanbanCard>> _columns = {
    'Pendiente': [
      KanbanCard(id: '1', title: 'Diseñar UI', priority: 'alta'),
      KanbanCard(id: '2', title: 'Revisar PR', priority: 'media'),
    ],
    'En Progreso': [
      KanbanCard(id: '3', title: 'Implementar API', priority: 'alta'),
    ],
    'Completado': [],
  };

  // Colores de cabecera por columna
  final Map<String, Color> _columnColors = {
    'Pendiente': Colors.orange,
    'En Progreso': Colors.blue,
    'Completado': Colors.green,
  };

  void _moveCard(KanbanCard card, String fromColumn, String toColumn) {
    if (fromColumn == toColumn) return;
    setState(() {
      _columns[fromColumn]!.removeWhere((c) => c.id == card.id);
      _columns[toColumn]!.add(card);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Tablero Kanban'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Row(
        children: _columns.entries.map((entry) {
          return Expanded(
            child: DragTarget<Map<String, dynamic>>(
              onWillAcceptWithDetails: (details) {
                // Solo aceptar si la tarjeta viene de otra columna
                return details.data['from'] != entry.key;
              },
              onAcceptWithDetails: (details) {
                _moveCard(
                  details.data['card'] as KanbanCard,
                  details.data['from'] as String,
                  entry.key,
                );
              },
              builder: (context, candidateData, _) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: candidateData.isNotEmpty
                        ? _columnColors[entry.key]!.withValues(alpha: 0.15)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: candidateData.isNotEmpty
                          ? _columnColors[entry.key]!
                          : Colors.grey.shade300,
                      width: candidateData.isNotEmpty ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cabecera de columna
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: _columnColors[entry.key],
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              entry.key,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.white,
                              child: Text(
                                '${entry.value.length}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: _columnColors[entry.key],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Tarjetas de la columna
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(8),
                          children: entry.value.map((card) {
                            return LongPressDraggable<Map<String, dynamic>>(
                              data: {'card': card, 'from': entry.key},
                              hapticFeedbackOnStart: true,
                              feedback: Material(
                                elevation: 8,
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  width: 160,
                                  child: _buildCard(card, dragging: false),
                                ),
                              ),
                              childWhenDragging: Opacity(
                                opacity: 0.3,
                                child: _buildCard(card),
                              ),
                              child: _buildCard(card),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCard(KanbanCard card, {bool dragging = false}) {
    final priorityColors = {
      'alta': Colors.red,
      'media': Colors.orange,
      'baja': Colors.green,
    };
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: dragging ? 0 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: priorityColors[card.priority]!.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: priorityColors[card.priority]!),
              ),
              child: Text(
                'Prioridad ${card.priority}',
                style: TextStyle(
                  fontSize: 11,
                  color: priorityColors[card.priority],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
