extends Control


func set_outcome(successful: bool, total_score: int, collectible_score: int, time_score: int, health_score):
	if successful:
		$Title.text = "You did it!"
	
	$Scores/CollectibleScore/Value.text = str(collectible_score)
	$Scores/TimeScore/Value.text = str(time_score)
	$Scores/HealthScore/Value.text = str(health_score)
	$Scores/TotalScore/Value.text = str(total_score)
