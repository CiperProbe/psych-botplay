local notesHitCount = 0

function onCreate()
    setProperty('cpuControlled', true)
    setProperty('botplayTxt.visible', false)
    notesHitCount = 0
end

function onCreatePost()
    setProperty('cpuControlled', true)
    setProperty('botplayTxt.visible', false)
    setProperty('ratingName', 'Sick')
    setRatingPercent(1.0)
    setProperty('accuracy', 100.0)
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        return
    end
    
    if not getProperty('cpuControlled') then
        setProperty('cpuControlled', true)
    end
    
    notesHitCount = notesHitCount + 1
    
    setProperty('ratingName', 'Sick')
    setRatingPercent(1.0)
    setRatingFC('SFC')
    
    addScore(350)
    addHits(1)
    
    updateScoreText()
    
    runTimer('fixRating', 0.001, 1)
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'fixRating' then
        setProperty('totalNotesHit', notesHitCount)
        setProperty('totalNotesMissed', 0)
        setProperty('totalPlayed', notesHitCount)
        setProperty('ratingName', 'Sick')
        setRatingPercent(1.0)
    end
end

function noteMissPress(direction)
    addMisses(1)
    setProperty('songMisses', getProperty('songMisses') + 1)
    updateScoreText()
    
    setRatingPercent(1.0)
    setProperty('accuracy', 100.0)
    setProperty('ratingName', 'Sick')
    setProperty('cpuControlled', true)
end

function noteMiss(id, direction, noteType, isSustainNote)
    addMisses(1)
    setProperty('songMisses', getProperty('songMisses') + 1)
    updateScoreText()
    
    setRatingPercent(1.0)
    setProperty('accuracy', 100.0)
    setProperty('ratingName', 'Sick')
    setProperty('cpuControlled', true)
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    setProperty('cpuControlled', true)
    return
end

function onUpdatePost(elapsed)
    setProperty('ratingName', 'Sick')
    setRatingPercent(1.0)
    
    local expectedTotal = notesHitCount * 1.0
    local currentTotal = getProperty('totalNotesHit')
    
    if currentTotal ~= expectedTotal and notesHitCount > 0 then
        setProperty('totalNotesHit', expectedTotal)
    end
    
    setProperty('totalNotesMissed', 0)
    setProperty('totalPlayed', notesHitCount)
    
    setProperty('accuracy', 100.0)
    setProperty('ratingPercent', 1.0)
    
    if getProperty('songMisses') == 0 then
        setRatingFC('SFC')
    else
        setRatingFC('FC')
    end
    updateScoreText()
    
    setProperty('cpuControlled', true)
    setProperty('botplayTxt.visible', false)
    
    if getHealth() < 2 then
        setHealth(2)
    end
end

function onStepHit()
    setProperty('ratingName', 'Sick')
    setRatingPercent(1.0)
    setProperty('accuracy', 100.0)
    setProperty('cpuControlled', true)
end

function onBeatHit()
    setProperty('ratingName', 'Sick')
    setRatingPercent(1.0)
    setProperty('accuracy', 100.0)
    setProperty('cpuControlled', true)
end

function onCountdownTick(counter)
    setProperty('cpuControlled', true)
end

function onCountdownStarted()
    setProperty('cpuControlled', true)
end

function onStartCountdown()
    setProperty('cpuControlled', true)
    return Function_Continue
end

function onEvent(name, value1, value2)
    setProperty('cpuControlled', true)
end

function onSongStart()
    setProperty('cpuControlled', true)
end

function onEndSong()
    setProperty('cpuControlled', true)
    return Function_Continue
end

function onDestroy()
    setProperty('cpuControlled', false)
    setProperty('botplayTxt.visible', false)
end
