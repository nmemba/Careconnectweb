import React, { forwardRef } from 'react';

interface InputProps extends React.InputHTMLAttributes<HTMLInputElement> {
  label?: string;
  error?: string;
  helperText?: string;
  leftIcon?: React.ReactNode;
  rightIcon?: React.ReactNode;
  fullWidth?: boolean;
}

export const Input = forwardRef<HTMLInputElement, InputProps>(
  (
    {
      label,
      error,
      helperText,
      leftIcon,
      rightIcon,
      fullWidth = false,
      className = '',
      id,
      ...props
    },
    ref
  ) => {
    const inputId = id || `input-${Math.random().toString(36).substr(2, 9)}`;

    return (
      <div className={`${fullWidth ? 'w-full' : ''}`}>
        {label && (
          <label
            htmlFor={inputId}
            className="block text-sm font-medium text-[var(--color-text-primary)] mb-2"
          >
            {label}
          </label>
        )}
        
        <div className="relative">
          {leftIcon && (
            <div className="absolute left-3 top-1/2 -translate-y-1/2 text-[var(--color-text-secondary)]">
              {leftIcon}
            </div>
          )}
          
          <input
            ref={ref}
            id={inputId}
            className={`
              w-full px-4 py-3 bg-white border border-[var(--color-border)] rounded-lg
              text-[var(--color-text-primary)] placeholder:text-[var(--color-text-disabled)]
              hover:border-[var(--color-primary)]
              focus:outline-none focus:ring-2 focus:ring-[var(--color-primary)] focus:ring-offset-2
              disabled:opacity-50 disabled:cursor-not-allowed disabled:bg-[var(--color-surface)]
              transition-all duration-200
              ${leftIcon ? 'pl-10' : ''}
              ${rightIcon ? 'pr-10' : ''}
              ${error ? 'border-[var(--color-error)] focus:ring-[var(--color-error)]' : ''}
              ${className}
            `}
            aria-invalid={error ? 'true' : 'false'}
            aria-describedby={
              error ? `${inputId}-error` : helperText ? `${inputId}-helper` : undefined
            }
            {...props}
          />
          
          {rightIcon && (
            <div className="absolute right-3 top-1/2 -translate-y-1/2 text-[var(--color-text-secondary)]">
              {rightIcon}
            </div>
          )}
        </div>
        
        {error && (
          <p id={`${inputId}-error`} className="mt-2 text-sm text-[var(--color-error)]" role="alert">
            {error}
          </p>
        )}
        
        {!error && helperText && (
          <p id={`${inputId}-helper`} className="mt-2 text-sm text-[var(--color-text-secondary)]">
            {helperText}
          </p>
        )}
      </div>
    );
  }
);

Input.displayName = 'Input';

interface TextareaProps extends React.TextareaHTMLAttributes<HTMLTextAreaElement> {
  label?: string;
  error?: string;
  helperText?: string;
  fullWidth?: boolean;
}

export const Textarea = forwardRef<HTMLTextAreaElement, TextareaProps>(
  (
    {
      label,
      error,
      helperText,
      fullWidth = false,
      className = '',
      id,
      rows = 4,
      ...props
    },
    ref
  ) => {
    const textareaId = id || `textarea-${Math.random().toString(36).substr(2, 9)}`;

    return (
      <div className={`${fullWidth ? 'w-full' : ''}`}>
        {label && (
          <label
            htmlFor={textareaId}
            className="block text-sm font-medium text-[var(--color-text-primary)] mb-2"
          >
            {label}
          </label>
        )}
        
        <textarea
          ref={ref}
          id={textareaId}
          rows={rows}
          className={`
            w-full px-4 py-3 bg-white border border-[var(--color-border)] rounded-lg
            text-[var(--color-text-primary)] placeholder:text-[var(--color-text-disabled)]
            hover:border-[var(--color-primary)]
            focus:outline-none focus:ring-2 focus:ring-[var(--color-primary)] focus:ring-offset-2
            disabled:opacity-50 disabled:cursor-not-allowed disabled:bg-[var(--color-surface)]
            transition-all duration-200 resize-vertical
            ${error ? 'border-[var(--color-error)] focus:ring-[var(--color-error)]' : ''}
            ${className}
          `}
          aria-invalid={error ? 'true' : 'false'}
          aria-describedby={
            error ? `${textareaId}-error` : helperText ? `${textareaId}-helper` : undefined
          }
          {...props}
        />
        
        {error && (
          <p id={`${textareaId}-error`} className="mt-2 text-sm text-[var(--color-error)]" role="alert">
            {error}
          </p>
        )}
        
        {!error && helperText && (
          <p id={`${textareaId}-helper`} className="mt-2 text-sm text-[var(--color-text-secondary)]">
            {helperText}
          </p>
        )}
      </div>
    );
  }
);

Textarea.displayName = 'Textarea';

interface CheckboxProps extends Omit<React.InputHTMLAttributes<HTMLInputElement>, 'type'> {
  label: string;
  error?: string;
}

export const Checkbox = forwardRef<HTMLInputElement, CheckboxProps>(
  ({ label, error, className = '', id, ...props }, ref) => {
    const checkboxId = id || `checkbox-${Math.random().toString(36).substr(2, 9)}`;

    return (
      <div>
        <div className="flex items-center gap-3">
          <input
            ref={ref}
            type="checkbox"
            id={checkboxId}
            className={`
              w-5 h-5 rounded border-2 border-[var(--color-border)]
              text-[var(--color-primary)] 
              focus:ring-2 focus:ring-[var(--color-primary)] focus:ring-offset-2
              disabled:opacity-50 disabled:cursor-not-allowed
              cursor-pointer
              ${error ? 'border-[var(--color-error)]' : ''}
              ${className}
            `}
            aria-invalid={error ? 'true' : 'false'}
            aria-describedby={error ? `${checkboxId}-error` : undefined}
            {...props}
          />
          <label
            htmlFor={checkboxId}
            className="text-[var(--color-text-primary)] cursor-pointer select-none"
          >
            {label}
          </label>
        </div>
        
        {error && (
          <p id={`${checkboxId}-error`} className="mt-2 text-sm text-[var(--color-error)]" role="alert">
            {error}
          </p>
        )}
      </div>
    );
  }
);

Checkbox.displayName = 'Checkbox';

interface RadioProps extends Omit<React.InputHTMLAttributes<HTMLInputElement>, 'type'> {
  label: string;
  error?: string;
}

export const Radio = forwardRef<HTMLInputElement, RadioProps>(
  ({ label, error, className = '', id, ...props }, ref) => {
    const radioId = id || `radio-${Math.random().toString(36).substr(2, 9)}`;

    return (
      <div>
        <div className="flex items-center gap-3">
          <input
            ref={ref}
            type="radio"
            id={radioId}
            className={`
              w-5 h-5 border-2 border-[var(--color-border)]
              text-[var(--color-primary)]
              focus:ring-2 focus:ring-[var(--color-primary)] focus:ring-offset-2
              disabled:opacity-50 disabled:cursor-not-allowed
              cursor-pointer
              ${error ? 'border-[var(--color-error)]' : ''}
              ${className}
            `}
            aria-invalid={error ? 'true' : 'false'}
            aria-describedby={error ? `${radioId}-error` : undefined}
            {...props}
          />
          <label
            htmlFor={radioId}
            className="text-[var(--color-text-primary)] cursor-pointer select-none"
          >
            {label}
          </label>
        </div>
        
        {error && (
          <p id={`${radioId}-error`} className="mt-2 text-sm text-[var(--color-error)]" role="alert">
            {error}
          </p>
        )}
      </div>
    );
  }
);

Radio.displayName = 'Radio';

interface SwitchProps extends Omit<React.InputHTMLAttributes<HTMLInputElement>, 'type'> {
  label?: string;
  description?: string;
}

export const Switch = forwardRef<HTMLInputElement, SwitchProps>(
  ({ label, description, className = '', id, checked, ...props }, ref) => {
    const switchId = id || `switch-${Math.random().toString(36).substr(2, 9)}`;

    return (
      <div className="flex items-center justify-between gap-4">
        <div className="flex-1">
          {label && (
            <label htmlFor={switchId} className="block font-medium text-[var(--color-text-primary)] cursor-pointer">
              {label}
            </label>
          )}
          {description && (
            <p className="text-sm text-[var(--color-text-secondary)] mt-1">{description}</p>
          )}
        </div>
        
        <button
          type="button"
          role="switch"
          aria-checked={checked}
          onClick={() => {
            const event = new Event('change', { bubbles: true });
            const input = document.getElementById(switchId) as HTMLInputElement;
            if (input) {
              input.checked = !input.checked;
              input.dispatchEvent(event);
            }
          }}
          className={`
            relative inline-flex h-7 w-12 items-center rounded-full
            transition-colors duration-200 ease-in-out
            focus:outline-none focus:ring-2 focus:ring-[var(--color-primary)] focus:ring-offset-2
            ${checked ? 'bg-[var(--color-primary)]' : 'bg-gray-300'}
            ${className}
          `}
        >
          <span
            className={`
              inline-block h-5 w-5 transform rounded-full bg-white shadow-sm
              transition-transform duration-200 ease-in-out
              ${checked ? 'translate-x-6' : 'translate-x-1'}
            `}
          />
        </button>
        
        <input
          ref={ref}
          type="checkbox"
          id={switchId}
          checked={checked}
          className="sr-only"
          {...props}
        />
      </div>
    );
  }
);

Switch.displayName = 'Switch';
