local notesHitCount = 0
local lastUpdateTime = 0
local lastPostUpdateTime = 0
local UPDATE_INTERVAL = 0.1
local manualScore = 0
local lastScoreUpdate = 0
local SCORE_UPDATE_INTERVAL = 0.05

function onCreate()
    setProperty('cpuControlled', true)
    setProperty('botplayTxt.visible', false)
    setProperty('ratingName', 'Sick')
    setRatingPercent(1.0)
    setProperty('rating', 100.0)
    setRatingFC('SFC')
    notesHitCount = 0
    lastUpdateTime = 0
    lastPostUpdateTime = 0
    manualScore = 0
    lastScoreUpdate = 0
end

function onCreatePost()
    setProperty('cpuControlled', true)
    setProperty('botplayTxt.visible', false)
    updateScoreText()
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        return
    end
    
    notesHitCount = notesHitCount + 1
    manualScore = manualScore + 350
    
    local currentScore = getProperty('songScore')
    local previousScore = currentScore
    
    addScore(350)
    
    currentScore = getProperty('songScore')
    if currentScore <= previousScore then
        setProperty('songScore', manualScore)
    end
    
    addHits(1)
    
    setProperty('ratingName', 'Sick')
    setRatingPercent(1.0)
    setProperty('rating', 100.0)
    setRatingFC('SFC')
    
    updateScoreText()
    
    if not getProperty('cpuControlled') then
        setProperty('cpuControlled', true)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'fixRating' then
        setProperty('totalNotesHit', notesHitCount)
        setProperty('totalNotesMissed', 0)
        setProperty('totalPlayed', notesHitCount)
    end
end

function noteMissPress(direction)
    addMisses(1)
    setProperty('songMisses', getProperty('songMisses') + 1)
    setProperty('cpuControlled', true)
end

function noteMiss(id, direction, noteType, isSustainNote)
    addMisses(1)
    setProperty('songMisses', getProperty('songMisses') + 1)
    setProperty('cpuControlled', true)
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    setProperty('cpuControlled', true)
    return
end

function onUpdate(elapsed)
    lastUpdateTime = lastUpdateTime + elapsed
    lastScoreUpdate = lastScoreUpdate + elapsed
    
    if lastUpdateTime >= UPDATE_INTERVAL then
        setProperty('cpuControlled', true)
        setProperty('botplayTxt.visible', false)
        
        lastUpdateTime = 0
    end
    
    if lastScoreUpdate >= SCORE_UPDATE_INTERVAL then
        updateScoreText()
        lastScoreUpdate = 0
    end
end

function onUpdatePost(elapsed)
    lastPostUpdateTime = lastPostUpdateTime + elapsed
    
    if lastPostUpdateTime >= UPDATE_INTERVAL then
        local expectedTotal = notesHitCount * 1.0
        local currentTotal = getProperty('totalNotesHit')
        
        if currentTotal ~= expectedTotal and notesHitCount > 0 then
            setProperty('totalNotesHit', expectedTotal)
        end
        
        setProperty('totalNotesMissed', 0)
        setProperty('totalPlayed', notesHitCount)
        setProperty('ratingName', 'Sick')
        setRatingPercent(1.0)
        setProperty('rating', 100.0)
        setRatingFC('SFC')
        
        local currentScore = getProperty('songScore')
        if currentScore < manualScore then
            setProperty('songScore', manualScore)
        end
        
        updateScoreText()
        
        lastPostUpdateTime = 0
    end
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

function onRecalculateRating()
    return Function_Continue
end

function onRatingUpdate()
end

function updateScoreDisplay()
    local currentScore = getProperty('songScore')
    local scoreText = string.format('Score: %d', currentScore)
    
    if getProperty('scoreTxt') ~= nil then
        setProperty('scoreTxt.text', scoreText)
    end
    
    if getProperty('score') ~= nil then
        setProperty('score.text', scoreText)
    end
end

function updateScoreText()
    local currentScore = getProperty('songScore')
    local rating = 100.0
    local misses = getProperty('songMisses') or 0
    
    local fullScoreText = string.format('Score: %d | Misses: %d | Rating: %.1f%%', currentScore, misses, rating)
    
    if getProperty('scoreTxt') ~= nil then
        setProperty('scoreTxt.text', fullScoreText)
    end
    
    if getProperty('score') ~= nil then
        setProperty('score.text', fullScoreText)
    end
end
