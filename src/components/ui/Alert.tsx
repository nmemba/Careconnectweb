import React from 'react';
import { AlertCircle, CheckCircle, Info, XCircle, X } from 'lucide-react';
import { IconButton } from './Button';

interface AlertProps {
  variant?: 'info' | 'success' | 'warning' | 'error';
  title?: string;
  children: React.ReactNode;
  onClose?: () => void;
  className?: string;
}

export function Alert({
  variant = 'info',
  title,
  children,
  onClose,
  className = '',
}: AlertProps) {
  const variantConfig = {
    info: {
      bg: 'bg-blue-50',
      border: 'border-blue-200',
      text: 'text-blue-800',
      icon: <Info className="w-5 h-5" />,
    },
    success: {
      bg: 'bg-green-50',
      border: 'border-green-200',
      text: 'text-green-800',
      icon: <CheckCircle className="w-5 h-5" />,
    },
    warning: {
      bg: 'bg-orange-50',
      border: 'border-orange-200',
      text: 'text-orange-800',
      icon: <AlertCircle className="w-5 h-5" />,
    },
    error: {
      bg: 'bg-red-50',
      border: 'border-red-200',
      text: 'text-red-800',
      icon: <XCircle className="w-5 h-5" />,
    },
  };

  const config = variantConfig[variant];

  return (
    <div
      role="alert"
      className={`
        ${config.bg} ${config.border} ${config.text} 
        border rounded-lg p-4 flex gap-3 ${className}
      `}
    >
      <div className="flex-shrink-0">{config.icon}</div>
      <div className="flex-1">
        {title && <h4 className="font-semibold mb-1 m-0">{title}</h4>}
        <div className="text-sm">{children}</div>
      </div>
      {onClose && (
        <IconButton
          icon={<X className="w-4 h-4" />}
          label="Close alert"
          onClick={onClose}
          variant="ghost"
          size="sm"
        />
      )}
    </div>
  );
}
