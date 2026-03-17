import React from 'react';

interface CardProps {
  children: React.ReactNode;
  className?: string;
  variant?: 'default' | 'outlined' | 'elevated';
  padding?: 'none' | 'sm' | 'md' | 'lg';
  onClick?: () => void;
  interactive?: boolean;
}

export function Card({
  children,
  className = '',
  variant = 'default',
  padding = 'md',
  onClick,
  interactive = false,
}: CardProps) {
  const variantClasses = {
    default: 'bg-white border border-[var(--color-border)]',
    outlined: 'bg-transparent border-2 border-[var(--color-border)]',
    elevated: 'bg-white shadow-[var(--shadow-md)] border border-[var(--color-border)]',
  };

  const paddingClasses = {
    none: '',
    sm: 'p-4',
    md: 'p-6',
    lg: 'p-8',
  };

  const interactiveClasses = interactive || onClick
    ? 'cursor-pointer hover:shadow-[var(--shadow-lg)] hover:border-[var(--color-primary)] transition-all duration-200'
    : '';

  const Component = onClick ? 'button' : 'div';

  return (
    <Component
      onClick={onClick}
      className={`
        rounded-xl ${variantClasses[variant]} ${paddingClasses[padding]} ${interactiveClasses} ${className}
      `}
    >
      {children}
    </Component>
  );
}

interface CardHeaderProps {
  title: string;
  subtitle?: string;
  action?: React.ReactNode;
  className?: string;
}

export function CardHeader({ title, subtitle, action, className = '' }: CardHeaderProps) {
  return (
    <div className={`flex items-start justify-between gap-4 ${className}`}>
      <div className="flex-1">
        <h3 className="text-lg font-semibold text-[var(--color-text-primary)] m-0">
          {title}
        </h3>
        {subtitle && (
          <p className="text-sm text-[var(--color-text-secondary)] mt-1 m-0">
            {subtitle}
          </p>
        )}
      </div>
      {action && <div className="flex-shrink-0">{action}</div>}
    </div>
  );
}

interface CardContentProps {
  children: React.ReactNode;
  className?: string;
}

export function CardContent({ children, className = '' }: CardContentProps) {
  return <div className={`mt-4 ${className}`}>{children}</div>;
}

interface CardFooterProps {
  children: React.ReactNode;
  className?: string;
}

export function CardFooter({ children, className = '' }: CardFooterProps) {
  return (
    <div className={`mt-6 pt-4 border-t border-[var(--color-border)] ${className}`}>
      {children}
    </div>
  );
}
