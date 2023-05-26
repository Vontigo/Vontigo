export function mapForeignKey(json: ForeignKey): Record<string, ForeignKey> {
	const { from, ...rest } = json;
	return { [from]: { ...rest, from } };
}

export function typeMapping(type: string) {
	let returnType = type;

	//if (!DATABASE_TYPE === 'development') {
	switch (type) {
		case 'character varying':
			returnType = 'varchar';
			break;
		case 'timestamp without time zone':
			returnType = 'datetime';
			break;
	}
	//}

	return returnType;
}

export function valueMapping(type: string, value: string) {
	let returnValue: any = value;

	//if (!DATABASE_TYPE === 'development') {
	switch (type) {
		case 'boolean':
			returnValue = value == false ? 0 : 1;
			break;
		case 'timestamp without time zone':
			const dateObj = new Date(value);
			const formattedDateTime = dateObj.toISOString().slice(0, -5);
			returnValue = formattedDateTime;
			break;
	}
	//}

	return returnValue;
}
