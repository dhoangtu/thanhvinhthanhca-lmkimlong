% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Lên Ngôi Thống Trị" }
  composer = "Kh. 11,17-18;12,10-12"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 d8 |
  b2 ~ |
  b8 a d
  <<
    {
      \voiceOne
      fs,8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-1.2
      \tweak font-size #-2
      \parenthesize
      a
    }
  >>
  \oneVoice
  g4 r8 b16 g |
  c8 a4
  <<
    {
      \voiceOne
      d8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-1
      \tweak font-size #-2
      \parenthesize
      a
    }
  >>
  \oneVoice
  d4 r8 d |
  a8. a16 e (g) e8 |
  d4. a'16 g |
  fs8 fs a g |
  b8. a16 \tuplet 3/2 { c8 c d } |
  g,4 r8 \bar "||" \break
  
  b |
  c8. c16 a8 d |
  g,4 r8 fs |
  g8. g16 g8 a |
  d,4 r8 d |
  b'4. a8 |
  b c d8. e16 |
  d8 b r a |
  c b a d |
  fs,8. fs16 a8 d, |
  g4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r8 |
  R2*9
  r4.
  g8 |
  a8. g16 fs8 fs |
  g4 r8 d |
  e8. e16 e8 cs |
  d4 r8 d |
  g4. fs8 |
  g a b8. c16 |
  b8 g r fs |
  a g fs e |
  d8. d16 c8 c |
  b4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Lạy Chúa, Thiên Chúa toàn năng,
      Đấng hiện có và đã có,
      Chúng con xin cảm tạ Ngài
      Đã sử dụng quyền năng mạnh mẽ
      mà lên ngôi thống trị.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Ngàn dân đã phẫn nộ lên,
	    Cơn giận Chúa liền trút xuống,
	    Chúa nay xét xử vong hồn,
	    Sẽ thowngr thọ bề tôi của Chúa
	    là bao Ngôn sứ Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Vì Chúa nay sẽ thưởng công
	    những người vốn thuộc
	    \markup { \italic \underline "về" } Chúa,
	    Những ai tôn sợ Danh Ngài,
	    Khắp thiên đình cùng chư thần thánh
	    hãy hân hoan hát mừng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Này chính quỷ dữ
	    \markup { \italic \underline "Sa" } -- tan,
	    Kẻ hằng cáo tội anh em,
	    Những anh em của ta này,
	    Cáo họ ngày ngày trước tòa Chúa
	    rầy bị đuổi ra ngoài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Họ đã vinh thắng vẻ vang,
	    Chính nhờ máu của Chiên Con,
	    Dám coi kinh cả sinh mạng,
	    Giữ bao lời làm chứng về Chúa
	    nguyện hy sinh đến cùng.
    }
  >>
  \set stanza = "ĐK:"
  Thiên Chúa chúng ta kính thờ,
  giờ đây ban ơn cứu độ,
  giờ đây biểu dương uy dũng với vương quyền,
  và Đức Ki -- tô của Ngài tỏ rõ quyền năng.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
  page-count = 1
}

TongNhip = {
  \key g \major \time 2/4
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
