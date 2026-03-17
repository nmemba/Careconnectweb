import React from 'react';

interface BadgeProps {
  children: React.ReactNode;
  variant?: 'primary' | 'secondary' | 'success' | 'warning' | 'error' | 'neutral';
  size?: 'sm' | 'md' | 'lg';
  className?: string;
}

export function Badge({ children, variant = 'primary', size = 'md', className = '' }: BadgeProps) {
  const variantClasses = {
    primary: 'bg-[var(--color-primary-light)] text-[var(--color-primary)] border-[var(--color-primary)]',
    secondary: 'bg-green-50 text-[var(--color-secondary)] border-[var(--color-secondary)]',
    success: 'bg-green-50 text-green-700 border-green-700',
    warning: 'bg-orange-50 text-orange-700 border-orange-700',
    error: 'bg-red-50 text-red-700 border-red-700',
    neutral: 'bg-gray-100 text-gray-700 border-gray-700',
  };

  const sizeClasses = {
    sm: 'px-2 py-0.5 text-xs',
    md: 'px-3 py-1 text-sm',
    lg: 'px-4 py-1.5 text-base',
  };

  return (
    <span
      className={`
        inline-flex items-center justify-center font-medium rounded-full border
        ${variantClasses[variant]} ${sizeClasses[size]} ${className}
      `}
    >
      {children}
    </span>
  );
}

interface DotBadgeProps {
  variant?: 'primary' | 'secondary' | 'success' | 'warning' | 'error';
  size?: 'sm' | 'md' | 'lg';
  pulse?: boolean;
  className?: string;
}

export function DotBadge({ variant = 'primary', size = 'md', pulse = false, className = '' }: DotBadgeProps) {
  const variantClasses = {
    primary: 'bg-[var(--color-primary)]',
    secondary: 'bg-[var(--color-secondary)]',
    success: 'bg-green-500',
    warning: 'bg-orange-500',
    error: 'bg-red-500',
  };

  const sizeClasses = {
    sm: 'w-2 h-2',
    md: 'w-3 h-3',
    lg: 'w-4 h-4',
  };

  return (
    <span className={`relative inline-flex ${className}`}>
      <span className={`rounded-full ${variantClasses[variant]} ${sizeClasses[size]}`} />
      {pulse && (
        <span
          className={`absolute inline-flex h-full w-full rounded-full ${variantClasses[variant]} opacity-75 animate-ping`}
        />
      )}
    </span>
  );
}
