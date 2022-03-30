% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Thương Cứu Độ" }
  composer = "Is. 35,10-14.17-20"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 a8 |
  d8. bf16 \tuplet 3/2 { g8 g g } |
  a4 \tuplet 3/2 { a8 f g } |
  g2 |
  g4 \tuplet 3/2 { a8 f d } |
  d8. d16 \tuplet 3/2 { a8 f' e } |
  e4 r8 g |
  a8.
  <<
    {
      \voiceOne
      a16
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #-1.2
      \parenthesize
      f16
    }
  >>
  \oneVoice
  \tuplet 3/2 { f8 f a } |
  bf4 \tuplet 3/2 { bf8 bf a } |
  g2 |
  a4 \tuplet 3/2 { f8 g f } |
  e8. a,16 \tuplet 3/2 { f'8 e
  <<
    {
      \voiceOne
      d8
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #-1.2
      \parenthesize
      e8
    }
  >>
  }
  \oneVoice
  \partial 4 d4 \bar "||" \break
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  \partial 4 d4 |
  a'2 |
  fs8 fs g (fs) |
  e4. e16 e |
  e8 g fs4 ~ |
  fs8 d b' b |
  a2 |
  a4 fs8 (a) |
  b4. b8 |
  g4 e |
  d2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*11
  r4
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  \partial 4 d4 |
  cs2 |
  d8 d e (d) |
  a4. a16 a |
  a8 e' d4 ~ |
  d8 d g g |
  fs2 |
  fs4 d8 (fs) |
  g4. g8 |
  e4 cs |
  d2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Tôi nói: nửa cuộc đời dở dang đã phải ra đi,
      Bao tháng năm còn lại giam tại cửa âm ty.
      Tôi nói: Hết được nhìn xem Chúa giữa cõi dương gian,
      hết nhìn thấy con người còn sống trên trần đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nãy bỗng cửa nhà bị giật tung
	    cuốn lại đem đi,
	    Đâu khác chi là lều của mục tử phiêu du,
	    Tay Chúa giống thợ dệt đem xén kiếp sống con đi,
	    Cứ để con mỏi mòn từ sớm qua
	    \markup { \italic \underline "đêm" } trường.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Từ sớm con miệt mài gào than,
	    sức lực tiêu hao,
	    Nay khác chi đã bị sư tử nghiền nát xương,
	    Như những tiếng nhạn kêu chim chíp,
	    giống tiếng chim câu,
	    Mãi nhìn luôn lên Ngài cặp mắt con
	    \markup { \italic \underline "lu" } mờ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài cứu con khỏi vực diệt vong,
	    ném tội con đi,
	    Ban phúc an bình lại thay nhục nhã chua cay,
	    Khi chết ai còn tạ ơn Chúa,
	    hết biết ca khen,
	    Những kẻ đã xuống mồ cũng hết tin cậy Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Lạy Chúa, chỉ người nào còn sống mới ngợi khen thôi,
	    Như tiếng con miệt mài ca tụng Chúa hôm nay,
	    Cha sẽ \markup { \italic \underline "truyền" }
	    dạy để con cháu tiếp nối mai sau
	    Biết rằng Chúa cao vời hằng tín trung
	    \markup { \italic \underline "muôn" } đời.
    }
  >>
  \set stanza = "ĐK:"
  Lạy Chúa, xin thương cứu độ
  để ngày ngày chúng con đàn hát xướng ca
  trong nhà Chúa suốt cả cuộc đời.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 0.5\mm
  bottom-margin = 0.5\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = 1
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
