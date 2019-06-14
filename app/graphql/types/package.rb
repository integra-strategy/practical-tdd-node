class Types::Package < Types::BaseEnum
  DAILY = :DAILY
  MONTHLY_MANUAL = :MONTHLY_MANUAL
  MONTHLY_RECURRING = :MONTHLY_RECURRING
  YEARLY = :YEARLY

  value DAILY, "Daily"
  value MONTHLY_MANUAL, "Month to month with manual renewal"
  value MONTHLY_RECURRING, "Month to month with automatic renewal"
  value YEARLY, "Yearly"
end