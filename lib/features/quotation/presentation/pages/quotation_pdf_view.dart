import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';

class QuotationPdfView extends StatelessWidget {
  final String pdfPath;

  const QuotationPdfView({
    super.key,
    required this.pdfPath,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotation Detail"),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              await Share.shareXFiles([XFile(pdfPath)]);
            },
          ),
        ],
      ),
      body: File(pdfPath).existsSync()
          ? PDFView(
        filePath: pdfPath,
        enableSwipe: true,
        autoSpacing: true,
        pageFling: true,
      )
          : const Center(
        child: Text("PDF not found"),
      ),
      bottomNavigationBar: _BottomActionBar(
        onDuplicate: () {},
        onEdit: () {},
        onInvoice: () {},
        onShare: () async {
          await Share.shareXFiles([XFile(pdfPath)]);
        },
        onMore: () => _showMoreOptions(context),
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              ListTile(
                leading: Icon(Icons.print),
                title: Text("Print"),
              ),
              ListTile(
                leading: Icon(Icons.download),
                title: Text("Download"),
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text("Delete"),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  final VoidCallback onDuplicate;
  final VoidCallback onEdit;
  final VoidCallback onInvoice;
  final VoidCallback onShare;
  final VoidCallback onMore;

  const _BottomActionBar({
    required this.onDuplicate,
    required this.onEdit,
    required this.onInvoice,
    required this.onShare,
    required this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(
            top: BorderSide(color: scheme.outlineVariant),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _ActionItem(
              icon: Icons.copy,
              label: "Duplicate",
              onTap: onDuplicate,
            ),
            _ActionItem(
              icon: Icons.edit,
              label: "Edit",
              onTap: onEdit,
            ),
            _ActionItem(
              icon: Icons.receipt_long,
              label: "Invoice",
              onTap: onInvoice,
            ),
            _ActionItem(
              icon: Icons.share,
              label: "Share",
              onTap: onShare,
            ),
            _ActionItem(
              icon: Icons.more_vert,
              label: "More",
              onTap: onMore,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: scheme.onSurfaceVariant,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: textTheme.labelSmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
