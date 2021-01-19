import React from 'react'
import { Icon } from '../../common/Icon'

export const PreviousSessionsLink = ({
  numSessions,
}: {
  numSessions: number
}): JSX.Element | null => {
  if (numSessions === 0) {
    return null
  }

  return (
    <div className="previous-sessions">
      {numSessions} previous sessions
      <Icon icon="modal" alt="Opens in modal" />
    </div>
  )
}