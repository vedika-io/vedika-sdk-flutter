/// A Vimshottari Dasha period.
class DashaPeriod {
  final String planet;
  final String startDate;
  final String endDate;
  final List<DashaPeriod>? subPeriods;

  const DashaPeriod({
    required this.planet,
    required this.startDate,
    required this.endDate,
    this.subPeriods,
  });

  factory DashaPeriod.fromJson(Map<String, dynamic> json) => DashaPeriod(
        planet: json['planet'] as String? ?? '',
        startDate: json['startDate'] as String? ??
            json['start_date'] as String? ??
            '',
        endDate:
            json['endDate'] as String? ?? json['end_date'] as String? ?? '',
        subPeriods: json['subPeriods'] != null || json['sub_periods'] != null
            ? ((json['subPeriods'] ?? json['sub_periods']) as List)
                .map((e) =>
                    DashaPeriod.fromJson(e as Map<String, dynamic>))
                .toList()
            : null,
      );
}

/// Current dasha information.
class CurrentDasha {
  final String mahaDasha;
  final String? antarDasha;
  final String? pratyantarDasha;
  final DashaPeriod? currentPeriod;

  const CurrentDasha({
    required this.mahaDasha,
    this.antarDasha,
    this.pratyantarDasha,
    this.currentPeriod,
  });

  factory CurrentDasha.fromJson(Map<String, dynamic> json) => CurrentDasha(
        mahaDasha: json['mahaDasha'] as String? ??
            json['maha_dasha'] as String? ??
            '',
        antarDasha: json['antarDasha'] as String? ??
            json['antar_dasha'] as String?,
        pratyantarDasha: json['pratyantarDasha'] as String? ??
            json['pratyantar_dasha'] as String?,
        currentPeriod: json['currentPeriod'] != null
            ? DashaPeriod.fromJson(
                json['currentPeriod'] as Map<String, dynamic>)
            : null,
      );
}
