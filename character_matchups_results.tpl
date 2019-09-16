%import math
<html>
	<head>
		<title>Ausmash: Win rates against each character</title>
		<style>
			.sortable th, .sortable td {
				border-width: 1px;
				border-style: solid;
			}
		</style>
		<script src="/js/sorttable.js"></script>
	</head>
	<body>
		<h1>Win rates against each character in {{game}} for {{player}} from {{region}}</h1>
		<table>
		%for group, char_list in summary.items():
			%#<h2>{{group}}</h2>
			%#{{', '.join(char_list)}}<br />
			<tr>
				<td>{{group}}</td>
				%#TODO: Get images from somewhere
				<td>{{', '.join(char_list)}}</td>
			</tr>
		%end
		</table>
		<table class='sortable'>
			<tr>
				<th>Character</th>
				<th>Wins</th>
				<th>Losses</th>
				<th>Total</th>
				<th>Win/Loss Ratio</th>
				<th>Win/Loss Difference</th>
				<th>Elo gain</th>
				<th>Elo loss</th>
				<th>Elo change</th>
				<th>Avg Elo change per match</th>
			</tr>

		%for name, row in matchups.items():
			<tr>
				<td>{{name}}</td>
				<td>{{row['Wins']}}</td>
				<td>{{row['Losses']}}</td>
				%total = row['Wins'] + row['Losses']
				<td>{{total}}</td>
				<td>{{'Never played' if row['Ratio'] is None else 'Never lost' if row['Ratio'] == math.inf else round(row['Ratio'], 2)}}</td>
				<td>{{row['Wins'] - row['Losses']}}</td>
				<td>{{row['Elo gain']}}</td>
				<td>{{row['Elo loss']}}</td>
				%elo_change = row['Elo gain'] - row['Elo loss']
				<td>{{elo_change}}</td>
				<td>{{round(elo_change / total, 2) if total != 0 else 'N/A'}}</td>
			</tr>
		%end
		</table>
	</body>
</html>