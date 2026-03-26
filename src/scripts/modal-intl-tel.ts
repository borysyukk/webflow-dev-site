import intlTelInput from 'intl-tel-input/intlTelInputWithUtils';
import 'intl-tel-input/build/css/intlTelInput.css';
import i18nUk from 'intl-tel-input/i18n/uk';

export function initModalIntlTel(): void {
	const input = document.querySelector<HTMLInputElement>('#modal-phone');
	const form = input?.closest('form');
	if (!input || !form) return;

	const iti = intlTelInput(input, {
		autoPlaceholder: 'off',
		initialCountry: 'ua',
		countrySearch: true,
		fixDropdownWidth: false,
		separateDialCode: true,
		strictMode: true,
		formatAsYouType: true,
		formatOnDisplay: true,
		allowedNumberTypes: ['MOBILE'],
		placeholderNumberType: 'MOBILE',
		countryNameLocale: 'uk',
		i18n: i18nUk,
		preferredCountries: ['ua', 'pl', 'de', 'gb', 'us'],
		dropdownContainer: document.body,
		containerClass: 'iti-modal-phone',
		/* E.164 у приховане phone; видиме поле без name — інакше дубль +380 при submit */
		hiddenInput: () => ({ phone: 'phone' }),
	});

	void iti.promise.then(() => {
		const n = iti.getNumber();
		if (n) iti.setNumber(n);
	});

	input.addEventListener('blur', () => {
		void iti.promise.then(() => {
			const n = iti.getNumber();
			if (n) iti.setNumber(n);
		});
	});

	const syncDropdownWidth = () => {
		const row = input.closest('.iti.iti-modal-phone');
		const panel = document.querySelector('.iti-modal-phone.iti--container');
		const dd = panel?.querySelector<HTMLElement>('.iti__dropdown-content');
		if (!row || !dd) return;
		const w = Math.round(row.getBoundingClientRect().width);
		if (w > 0) {
			dd.style.width = `${w}px`;
			dd.style.minWidth = `${w}px`;
			dd.style.maxWidth = `${w}px`;
			dd.style.boxSizing = 'border-box';
		}
	};

	const onDropdownMaybeOpen = () => {
		requestAnimationFrame(() => {
			requestAnimationFrame(syncDropdownWidth);
		});
	};

	input.addEventListener('open:countrydropdown', onDropdownMaybeOpen);
	window.addEventListener('resize', () => {
		const dd = document.querySelector('.iti-modal-phone.iti--container .iti__dropdown-content');
		if (dd && !dd.classList.contains('iti__hide')) syncDropdownWidth();
	});
}
